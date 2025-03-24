import 'package:kagi_kite_demo/services/network/base_api_client.dart';
import 'package:kagi_kite_demo/services/network/wikipedia/models/models.dart';

export 'models/models.dart';

class WikipediaApiClient extends BaseApiClient {
  /// Wikipedia summary of [query]. Will throw if Wikipedia cannot find result for [query].
  Future<GetSummaryResponse> getSummaryForQuery(String query) async {
    query = query.replaceAll(' ', '_'); // wikipedia won't accept '+' instead of a space. spaces need to be formatted with '_'
    return await getAndDeserialize(
      'https://en.wikipedia.org/api/rest_v1/page/summary/${Uri.encodeQueryComponent(query)}',
      (responseJson) => GetSummaryResponse.fromJson(responseJson)
    );
  }
}