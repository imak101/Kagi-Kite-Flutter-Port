import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/services/network/wikipedia/wikipedia_api_client.dart';
import 'package:mocktail/mocktail.dart';

class MockWikipediaApiClient extends Mock implements WikipediaApiClient {}

void main() {
  group('Test Mock WikipediaApiClient', () {
    final mockWikiClient = MockWikipediaApiClient();
    final String catSampleJson = File('test/sample_data/wikipedia/cat.json').readAsStringSync();

    test('Test Mock getSummaryForQuery()', () async {
      // stub implementation and return mock data
      when(() => mockWikiClient.getSummaryForQuery('Cat')).thenAnswer((_) => Future.value(GetSummaryResponse.fromJson(jsonDecode(catSampleJson))));

      final response = await mockWikiClient.getSummaryForQuery('Cat');

      expect(response.titles, isNotNull);
      expect(response.titles!.normalized, equals('Cat'));
      expect(response.originalImage, isNotNull);
      expect(response.originalImage!.sourceUrl, equals('https://upload.wikimedia.org/wikipedia/commons/1/15/Cat_August_2010-4.jpg'));
    });
  });

  group('Test Live WikipediaApiClient', () {
    final wikiClient = WikipediaApiClient();

    test('Test getSummaryForQuery()', () async {
      final response = await wikiClient.getSummaryForQuery('Cat');

      expect(response.titles, isNotNull);
      expect(response.titles!.normalized, equals('Cat'));
    });
  });
}