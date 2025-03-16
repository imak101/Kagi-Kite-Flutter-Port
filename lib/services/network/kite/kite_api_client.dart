import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models/models.dart';

export 'models/models.dart';

class KiteApiClient {
  static const String kiteApiPath = 'https://kite.kagi.com/';
  Uri _makeRequestUriFor(String requestedResource) => Uri.parse('$kiteApiPath$requestedResource');

  Future<GetShallowCategoriesResponse> getAllShallowCategories() async {
    return await _getAndDeserialize(
      _makeRequestUriFor('kite.json'),
      (responseJson) => GetShallowCategoriesResponse.fromJson(responseJson)
    );
  }

  Future<GetCategoryResponse> getCategory(ShallowKiteCategory category) async {
    return await _getAndDeserialize(
      _makeRequestUriFor(category.file),
      (responseJson) => GetCategoryResponse.fromJson(responseJson)
    );
  }

  // Future<GetOnThisDayResponse> getOnThisDay() {}

  Future<T> _getAndDeserialize<T>(Uri request, T Function(Map<String, Object?> responseJson) createResponse) async {
    final httpResponse = await http.get(request);
    return createResponse(jsonDecode(utf8.decode(httpResponse.bodyBytes))); // convert to utf8 so emojis are decoded correctly
  }
}