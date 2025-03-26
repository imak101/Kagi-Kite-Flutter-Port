import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

import '../../../util.dart';

void main() {
  final List<String> sampleEvents = [
    "2023-01-15:: Event 1",
    "2023-05-20:: Event 2",
    "2024-02-01:: Event 3"
  ];

  group('TimelineCard', () {
    testWidgets('renders correct number of timeline items', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TimelineCard(sampleEvents)));

      expect(find.text('1'), findsOneWidget); // finds the node number of timeline event
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);

      expect(find.widgetWithText(AutoSizeText, '2023-01-15'), findsOneWidget); // find each event's title
      expect(find.widgetWithText(AutoSizeText, '2023-05-20'), findsOneWidget);
      expect(find.widgetWithText(AutoSizeText, '2024-02-01'), findsOneWidget);
    });

    testWidgets('handles empty events list gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TimelineCard([])));

      expect(find.widgetWithText(StorySubtitleView, 'Timeline'), findsOneWidget); // ensure card and subtitle is still visible
      expect(find.byType(Card), findsOneWidget);

      expect(find.byType(AutoSizeText), findsNothing);
      expect(find.byType(VerticalDivider), findsNothing);
    });

    testWidgets('handles event string without separator "::"', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TimelineCard(['TestTestTest'])));

      expect(find.text('1'), findsOneWidget); // finds the node number of timeline event

      expect(find.widgetWithText(AutoSizeText, 'Error'), findsOneWidget); // find each event's title
      expect(find.widgetWithText(AutoSizeText, 'There was an error processing this event'), findsOneWidget);
    });

    testWidgets('handles event string with multiple separators "::"', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(TimelineCard(['TestTestTest']))); // same behavior as test above

      expect(find.text('1'), findsOneWidget); // finds the node number of timeline event

      expect(find.widgetWithText(AutoSizeText, 'Error'), findsOneWidget); // find each event's title
      expect(find.widgetWithText(AutoSizeText, 'There was an error processing this event'), findsOneWidget);
    });
  });
}