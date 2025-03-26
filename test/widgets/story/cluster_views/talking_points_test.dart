import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../util.dart';

void main() {
  final List<String> sampleTalkingPoints = [
    'Point 1: Blah',
    'Point 2: Blah Blah',
    'Point 3: Blah Blah Blah'
  ];

  group('TalkingPointsView', () {
    testWidgets('renders correct number of talking points', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TalkingPointsView(sampleTalkingPoints)));

      // ensure the text for each point is show
      final pointOne = sampleTalkingPoints[0].split(':');
      expect(find.text('1. ${pointOne.first}'), findsOneWidget); // finds title
      expect(find.text(pointOne.last.trim()), findsOneWidget); // finds content

      final pointTwo = sampleTalkingPoints[1].split(':');
      expect(find.text('2. ${pointTwo.first}'), findsOneWidget); // finds title
      expect(find.text(pointTwo.last.trim()), findsOneWidget);// finds content

      final pointThree = sampleTalkingPoints[2].split(':');
      expect(find.text('3. ${pointThree.first}'), findsOneWidget); // finds title
      expect(find.text(pointThree.last.trim()), findsOneWidget); // finds content\
    });

    testWidgets('renders WaveDivider between items but not after last', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TalkingPointsView(sampleTalkingPoints)));

      expect(find.byType(WaveDivider), findsNWidgets(2)); // divider should be between 1&2 and 2&3 NOT after item 3
    });

    testWidgets('handles empty talking points list gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TalkingPointsView([])));

      expect(find.byType(Card), findsOneWidget); // ensure the card is still shown
      expect(find.byType(ListView), findsOneWidget); // ensure list view is still present

      expect(find.byType(Text), findsOneWidget); // only subtitle text expected
      expect(find.byType(WaveDivider), findsNothing);
    });

    testWidgets('handles talking point string without colon', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(withApp(TalkingPointsView(['Invalid highlight text!'])));

      expect(find.text('1. Error'), findsOneWidget);
      expect(find.text('There was an error while processing this point.'), findsOneWidget);

      expect(find.byType(WaveDivider), findsNothing); // Only one item
    });

    testWidgets('handles talking point string with multiple colons', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TalkingPointsView(['This point has:::more than one colon'])));

      expect(find.text('1. This point has'), findsOneWidget);
      expect(find.text('::more than one colon'), findsOneWidget);

      expect(find.byType(WaveDivider), findsNothing); // Only one item
    });
  });
}