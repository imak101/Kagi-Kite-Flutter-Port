import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/shared/widgets.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

import '../../../util.dart';

void main() {
  group('StoryQuoteCard Tests', () {
    const testQuote = KiteQuote(
      'Test Quote',
      'Test Author',
      'testdomain.com',
      'https://www.test.com/',
    );

    testWidgets('should render quote text and hyperlink', (WidgetTester tester) async {
      // Arrange: Build the widget with test data
      await tester.pumpWidget(withApp(StoryQuoteCard(testQuote)));

      expect(find.byType(Card), findsOneWidget); // verify card

      expect(find.text(testQuote.text), findsOneWidget); // verify text is show

      expect(find.byType(HyperlinkView), findsOneWidget); // verify hyperlink view is shown

      expect(find.text('- ${testQuote.author} (via ${testQuote.sourceDomain})'), findsOneWidget); // ensure the hyperlink text is formatted correctly
    });
  });
}