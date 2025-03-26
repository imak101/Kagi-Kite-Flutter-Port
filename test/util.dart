import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kagi_kite_demo/routes/routes.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:mocktail/mocktail.dart';

MaterialApp withApp(Widget childWidget) {
  return MaterialApp(home: Scaffold(body: childWidget),);
}

// the functionality of these methods is tested in network/kite_api_test.dart
/// Sample based of production data, returns array with one element; the 'world' category
GetShallowCategoriesResponse getSampleShallowCategory() {
  final String shallowCategoriesJson = File('test/sample_data/kite.json').readAsStringSync();
  return GetShallowCategoriesResponse.fromJson(jsonDecode(shallowCategoriesJson));
}

/// Sample based of production data, returns with one data cluster in the 'world' category
GetCategoryResponse getSampleCategory() {
  final String worldCategoryJson = File('test/sample_data/world.json').readAsStringSync();
  return GetCategoryResponse.fromJson(jsonDecode(worldCategoryJson));
}

GetOnThisDayResponse getSampleOnThisDay() {
  final String onThisDayJson = File('test/sample_data/onthisday.json').readAsStringSync();
  return GetOnThisDayResponse.fromJson(jsonDecode(onThisDayJson));
}