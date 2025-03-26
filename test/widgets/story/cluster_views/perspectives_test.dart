import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kagi_kite_demo/widgets/story/widgets.dart';

import '../../../util.dart';


void main() {
  testWidgets('PerspectivesView displays correct number of cards', (WidgetTester tester) async {
    final sampleData = getSampleCategory().dataClusters.first.perspectives;

    await tester.pumpWidget(withApp(PerspectivesView(sampleData)));

    expect(find.byType(Card), findsNWidgets(sampleData.length));
  });

  testWidgets('PerspectivesView handles long text with overflowReplacement', (WidgetTester tester) async {
    final sampleData = getSampleCategory().dataClusters.first.perspectives;
    final overflowingText =
    """
    Lorem ipsum dolor sit amet. Ex exercitationem saepe et unde atque quo molestiae enim quo rerum modi et inventore error sed quas nostrum rem Quis pariatur. Quo voluptatem quaerat a dolor dolore et eaque asperiores ea amet molestias.
    Quo voluptates quisquam eum expedita temporibus sed possimus quidem non perferendis atque vel accusamus itaque vel doloremque quam est quisquam reprehenderit. Est corrupti quas qui iste similique qui unde vitae qui vitae voluptatem est necessitatibus corrupti. Qui laborum omnis aut ipsum ipsam est obcaecati quasi nam explicabo saepe. Id galisum laboriosam ut voluptatem dolor est maxime atque in nisi enim eum voluptatum rerum.
    """;
    await tester.pumpWidget(withApp(PerspectivesView([sampleData.first.copyWith.call(text: overflowingText)])));

    // The long text should be replaced by the FilledButton.
    expect(find.byType(FilledButton), findsOneWidget);
    expect(find.text('View'), findsOneWidget);
  });

  
  testWidgets('PerspectivesView handles empty perspectives list', (WidgetTester tester) async {
    await tester.pumpWidget(withApp(PerspectivesView([])));

    // Expect to find the StorySubtitleView, but no Cards.
    expect(find.byType(StorySubtitleView), findsOneWidget);
    expect(find.byType(Card), findsNothing);
  });


  testWidgets('PerspectivesView ListView is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(withApp(PerspectivesView(getSampleCategory().dataClusters.first.perspectives)));

    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);

    final listViewWidget = tester.widget<ListView>(listViewFinder);
    expect(listViewWidget.scrollDirection, Axis.horizontal);
  });
}