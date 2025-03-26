import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../util.dart';

class MockUrlLauncher extends Mock with MockPlatformInterfaceMixin implements UrlLauncherPlatform {}

// sample data
final publisher1 = KitePublisher(name: 'example.com', faviconUrl: 'http://example.com/favicon.ico');
final publisher2 = KitePublisher(name: 'anothersite.org', faviconUrl: ''); // No favicon
final publisher3 = KitePublisher(name: 'test.dev', faviconUrl: 'http://test.dev/icon.png');

final article1 = KiteArticle(domain: 'example.com', link: 'http://example.com/article1', title: 'Example Article 1', iso8601Date: 'TestDate', imageUrl: 'TestUrl', imageCaption: 'TestCaption');
final article2 = KiteArticle(domain: 'anothersite.org', link: 'http://anothersite.org/storyA', title: 'Another Story A', iso8601Date: 'TestDate', imageUrl: 'TestUrl', imageCaption: 'TestCaption');
final article3 = KiteArticle(domain: 'anothersite.org', link: 'http://anothersite.org/storyB', title: 'Another Story B', iso8601Date: 'TestDate', imageUrl: 'TestUrl', imageCaption: 'TestCaption');
final article4 = KiteArticle(domain: 'test.dev', link: 'http://test.dev/itemX', title: 'Test Item X', iso8601Date: 'TestDate', imageUrl: 'TestUrl', imageCaption: 'TestCaption');

final List<KitePublisher> samplePublishers = [publisher1, publisher2, publisher3];
final List<KiteArticle> sampleArticles = [article1, article2, article3, article4];

void main() {
  late MockUrlLauncher mockUrlLauncher;
  final sampleWidget = StorySourcesView(articles: sampleArticles, publishers: samplePublishers);

  setUpAll(() {
    registerFallbackValue(const LaunchOptions()); // fallback for urlLauncher options
  });

  setUp(() {
    mockUrlLauncher = MockUrlLauncher();
    UrlLauncherPlatform.instance = mockUrlLauncher;

    // stub urllauncher
    when(() => mockUrlLauncher.canLaunch(any())).thenAnswer((_) async => true);
    // Capture the URL passed to launchUrl
    when(() => mockUrlLauncher.launchUrl(any(), any())).thenAnswer((invocation) async {
      return true;
    });
  });

  group('StorySourcesView', () {
    testWidgets('initial state renders correctly with sources hidden', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      // verifies card that says 'Sources' and a down arrow
      expect(find.byType(Card), findsOneWidget);
      expect(find.widgetWithText(StorySubtitleView, 'Sources'), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);

      expect(find.byType(Visibility), findsOneWidget);
      final visibilityWidget = tester.widget<Visibility>(find.byType(Visibility)); // get visibility state for source buttons
      expect(visibilityWidget.visible, isFalse); // sources should be hidden initially
    });

    testWidgets('tapping header card toggles sources visibility', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton)); // tap the the down arrow that expands the sources
      await tester.pumpAndSettle();

      final visibilityWidget = tester.widget<Visibility>(find.byType(Visibility)); // Sources should now be visible
      expect(visibilityWidget.visible, isTrue);

      expect(find.byType(StorySourceButton), findsNWidgets(samplePublishers.length)); // should render buttons for each publisher

      await tester.tap(find.byType(IconButton)); // tap the arrow again to hide the sources
      await tester.pumpAndSettle();

      final visibilityWidgetAfterSecondTap = tester.widget<Visibility>(find.byType(Visibility));
      expect(visibilityWidgetAfterSecondTap.visible, isFalse, reason: 'Sources should be hidden after second tap'); // sources should be hidden again

      expect(find.byType(StorySourceButton), findsNothing); // source buttons should be removed after second tap
    });

    testWidgets('tapping source button with one article launches URL', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton)); // make source buttons visible
      await tester.pumpAndSettle();

      // tap the button for 'example.com' (which has 1 article)
      await tester.tap(find.widgetWithText(StorySourceButton, 'example.com'));
      await tester.pumpAndSettle();

      verify(() => mockUrlLauncher.launchUrl(article1.link, any())).called(1);
      // verify dialog was *not* shown. sources with one article will jump straight to the article (for now)
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('tapping source button with multiple articles shows dialog', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton)); // make source buttons visible
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(StorySourceButton, 'anothersite.org')); // tap the button for 'anothersite.org' (which has 2 articles)

      await tester.pumpAndSettle();

      // verify dialog is shown. sources with more than 1 article will have a dialog show so the user can choose which on they want to see
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Articles from ${publisher2.name}'), findsOneWidget); // Verify dialog title

      expect(find.byType(ListTile), findsNWidgets(2)); // verifies 2 list tiles are shown for 2 articles

      // Verify 'Close' button exists
      expect(find.widgetWithText(TextButton, 'Close'), findsOneWidget);
    });

    testWidgets('tapping list tile in dialog launches URL', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton)); // make source buttons visible
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(StorySourceButton, 'anothersite.org')); // tap the button for 'anothersite.org' (which has 2 articles)

      await tester.pumpAndSettle();

      // verify dialog is shown. sources with more than 1 article will have a dialog show so the user can choose which on they want to see
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Articles from ${publisher2.name}'), findsOneWidget); // Verify dialog title

      expect(find.byType(ListTile), findsNWidgets(2)); // verifies 2 list tiles are shown for 2 articles

      await tester.tap(find.byType(ListTile).first); // tap the first tile because there are 2 present

      await tester.pumpAndSettle();

      verify(() => mockUrlLauncher.launchUrl(article2.link, any())).called(1); // verify launchUrlString was called with the correct URL
    });

    testWidgets('tapping close button in dialog dismisses it', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(sampleWidget));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton)); // make source buttons visible
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(StorySourceButton, 'anothersite.org')); // tap the button for 'anothersite.org' to show dialog

      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget); // verify dialog is shown.

      await tester.tap(find.widgetWithText(TextButton, 'Close'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing); // verify dialog is no longer visible
    });
  });
}