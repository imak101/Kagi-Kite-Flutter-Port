import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:mocktail/mocktail.dart';

class MockKiteApiClient extends Mock implements KiteApiClient {}

void main() {
  group('Test MockKiteApiClient', () {
    final mockKiteApi = MockKiteApiClient();
    final String shallowCategoriesJson = File('test/sample_data/kite.json').readAsStringSync();
    final String worldCategoryJson = File('test/sample_data/world.json').readAsStringSync();
    final String onThisDayJson = File('test/sample_data/onthisday.json').readAsStringSync();

    test('test Mock getAllShallowCategories()', () async {
      // stub implementation and return mock data
      when(() => mockKiteApi.getAllShallowCategories()).thenAnswer((_) => Future.value(GetShallowCategoriesResponse.fromJson(jsonDecode(shallowCategoriesJson))));

      final response = await mockKiteApi.getAllShallowCategories();

      expect(response.shallowCategories.length, greaterThan(0));
      expect(response.shallowCategories.first.file, equals('world.json'));

      print('Got ${response.shallowCategories.length} mock shallow categories!');
    });
    
    test('test Mock getCategory(ShallowKiteCategory category)', () async {
      // stub implementation and return mock data
      registerFallbackValue(ShallowKiteCategory(name: 'World', file: 'world.json'));
      when(() => mockKiteApi.getCategory(any())).thenAnswer((_) => Future.value(GetCategoryResponse.fromJson(jsonDecode(worldCategoryJson))));

      final response = await mockKiteApi.getCategory(ShallowKiteCategory(name: 'World', file: 'world.json'));

      expect(response.categoryName, equals('World'));
      expect(response.dataClusters.length, equals(1)); // the mock sample only has one cluster
    });
    
    test('test Mock getOnThisDay()', () async {
      // stub implementation and return mock data
      when(() => mockKiteApi.getOnThisDay()).thenAnswer((_) => Future.value(GetOnThisDayResponse.fromJson(jsonDecode(onThisDayJson))));
      
      final response = await mockKiteApi.getOnThisDay();
      
      expect(response.allEvents.length, equals(6)); // sample size is 6
      expect(response.allEvents.first.content, equals('<b><a href=\"https://en.wikipedia.org/wiki/Rob_Ford\" data-wiki-id=\"Q169303\" title=\"Rob Ford\">Rob Ford</a></b> (Mayor of Toronto) died.'));
    });

    test('test Mock convenience extension', () async {
      when(() => mockKiteApi.getOnThisDay()).thenAnswer((_) => Future.value(GetOnThisDayResponse.fromJson(jsonDecode(onThisDayJson))));

      final response = await mockKiteApi.getOnThisDay();

      expect(response.people.length, equals(3));
      expect(response.historicalEvents.length, equals(3));
    });
  });

  group('Test Live KiteApiClient', () {
    final kiteClient = KiteApiClient();

    test('test Live getAllShallowCategories()', () async {
      final response = await kiteClient.getAllShallowCategories();

      expect(response.shallowCategories.length, greaterThan(0));
      expect(response.shallowCategories.first.file, equals('world.json'));

      print('Got ${response.shallowCategories.length} live shallow categories!');
    });

    test('test Live getCategory(ShallowKiteCategory category)', () async {
      final shallowResponse = await kiteClient.getAllShallowCategories();
      final worldCategoryShallow = shallowResponse.shallowCategories[0];
      expect(worldCategoryShallow.name, equals('World'));

      final worldCategory = await kiteClient.getCategory(worldCategoryShallow);
      expect(worldCategory.dataClusters.length, greaterThan(0));

      print('Top live Story Today: ${worldCategory.dataClusters.first.title}');
    });


    test('test Live "On This Day" category incompatibility', () async {
      final shallowResponse = await kiteClient.getAllShallowCategories();
      final onThisDayShallow = shallowResponse.shallowCategories.where((cat) => cat.name == 'OnThisDay').toList();
      expect(onThisDayShallow.length, equals(1));

      // should throw. the "On This Day" category needs to be deserialized with a different class
      await expectLater(kiteClient.getCategory(onThisDayShallow.first), throwsA(anything));
    });

    test('test live getOnThisDay()', () async {
      final response = await kiteClient.getOnThisDay();

      expect(response.allEvents, isNotEmpty);
      expect(response.timestamp, greaterThan(0));
    });

    test('ensure all categories deserialize for live client', () async {
      final shallowResponse = await kiteClient.getAllShallowCategories();
      final shallowCategories = shallowResponse.shallowCategories.where((cat) => cat.name != 'OnThisDay').toList();

      final deepCategories = <KiteCategoryCluster>[];
      for (final shallowCategory in shallowCategories) {
        final deepCatResponse = await kiteClient.getCategory(shallowCategory);
        deepCategories.addAll(deepCatResponse.dataClusters);
      }

      expect(deepCategories.length, greaterThan(0));
      print('Deserialized ${deepCategories.length} live stories across all categories');
    });
  });
}
