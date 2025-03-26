import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'package:kagi_kite_demo/routes/feed_page.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/widgets/story/compact_story_card.dart';
import 'package:mocktail/mocktail.dart';

import '../util.dart';

class MockKiteApiClient extends Mock implements KiteApiClient {}

void main() {
  final String shallowCategoriesJson = File('test/sample_data/kite.json').readAsStringSync();
  final String worldCategoryJson = File('test/sample_data/world.json').readAsStringSync();

  final mockKiteApi = MockKiteApiClient();

  setUpAll(() {
    registerFallbackValue(ShallowKiteCategory(name: 'World', file: 'world.json'));

    GetIt.I.registerSingleton<KiteApiClient>(mockKiteApi); // we use GetIt for DI
  });
  
  group('Test FeedPage widget', () {
    testWidgets('Test FeedPage shows error when the API throws error', (WidgetTester tester) async {
      when(() => mockKiteApi.getAllShallowCategories()).thenAnswer((_) => Future.error(ClientException('No Internet mock')));

      await tester.pumpWidget(withApp(const FeedPage()));

      await tester.pump();

      expect(find.byIcon(Icons.error_outline), findsOne);
      expect(find.textContaining('An error occurred'), findsOne);
      expect(find.text('World'), findsNothing); // ensure no categories are being shown
    });

    testWidgets('Test FeedPage data when there is not an API error', (WidgetTester tester) async {
      when(() => mockKiteApi.getAllShallowCategories()).thenAnswer((_) => Future.value(GetShallowCategoriesResponse.fromJson(jsonDecode(shallowCategoriesJson))));
      when(() => mockKiteApi.getCategory(any())).thenAnswer((_) => Future.value(GetCategoryResponse.fromJson(jsonDecode(worldCategoryJson))));

      await tester.pumpWidget(withApp(const FeedPage()));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsNothing);
      expect(find.textContaining('An error occurred'), findsNothing);

      // ensure the listview was drawn
      expect(find.text('World'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsAtLeast(1));
      expect(find.byType(CompactStoryCard), findsAtLeast(1));
    });

    testWidgets('Test FeedPage refresh button', (WidgetTester tester) async {
      when(() => mockKiteApi.getAllShallowCategories()).thenAnswer((_) => Future.error(ClientException('No Internet mock')));

      await tester.pumpWidget(withApp(const FeedPage()));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOne);
      expect(find.textContaining('An error occurred'), findsOne);
      expect(find.byType(FilledButton), findsOne); // retry button
      expect(find.text('World'), findsNothing); // ensure no categories are being shown


      when(() => mockKiteApi.getAllShallowCategories()).thenAnswer((_) => Future.value(GetShallowCategoriesResponse.fromJson(jsonDecode(shallowCategoriesJson))));
      when(() => mockKiteApi.getCategory(any())).thenAnswer((_) => Future.value(GetCategoryResponse.fromJson(jsonDecode(worldCategoryJson))));

      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsNothing);
      expect(find.textContaining('An error occurred'), findsNothing);

      // ensure the listview was drawn
      expect(find.text('World'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsAtLeast(1));
      expect(find.byType(CompactStoryCard), findsAtLeast(1));
    });
  });
}
