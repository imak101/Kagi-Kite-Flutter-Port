import 'package:kagi_kite_demo/services/network/base_api_client.dart';
import 'models/models.dart';

export 'models/models.dart';

class KiteApiClient extends BaseApiClient {
  static const String kiteApiPath = 'https://kite.kagi.com/';
  String _makeRequestFor(String requestedResource) => '$kiteApiPath$requestedResource';

  Future<GetShallowCategoriesResponse> getAllShallowCategories() async {
    return await getAndDeserialize(
      _makeRequestFor('kite.json'),
      (responseJson) => GetShallowCategoriesResponse.fromJson(responseJson)
    );
  }

  Future<GetCategoryResponse> getCategory(ShallowKiteCategory category) async {
    return await getAndDeserialize(
      _makeRequestFor(category.file),
      (responseJson) => GetCategoryResponse.fromJson(responseJson)
    );
  }

  Future<GetOnThisDayResponse> getOnThisDay() async {
    return await getAndDeserialize(
      _makeRequestFor('onthisday.json'),
      (responseJson) => GetOnThisDayResponse.fromJson(responseJson)
    );
  }
}