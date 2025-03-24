import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BaseApiClient {
  /// [createResponse] callback provides the decoded json object and and should return the DTO that you're deserializing to
  @protected
  Future<T> getAndDeserialize<T>(String httpRequest, T Function(Map<String, Object?> responseJson) createResponse) async {
    final httpResponse = await http.get(Uri.parse(httpRequest));
    return createResponse(jsonDecode(utf8.decode(httpResponse.bodyBytes))); // convert to utf8 so emojis and whatnot are decoded correctly
  }
}