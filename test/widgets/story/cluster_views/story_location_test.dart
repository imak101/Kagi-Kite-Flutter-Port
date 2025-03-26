import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/widgets/story/widgets.dart';

import '../../../util.dart';

void main() {
  group('StoryLocationView', () {
    const testLocation = 'Test Location';

    testWidgets('renders location text and icon', (WidgetTester tester) async {
      await tester.pumpWidget(withApp(StoryLocationView(testLocation)));

      // Verify the location icon is present
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);

      // Verify the location text is present
      expect(find.text(testLocation), findsOneWidget);
    });
  });
}