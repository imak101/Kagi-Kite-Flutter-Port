import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';

void main() {
  final kiteClient = KiteApiClient();

  test('test getAllShallowCategories()', () async {
    final response = await kiteClient.getAllShallowCategories();

    expect(response.shallowCategories.length, greaterThan(0));
    expect(response.shallowCategories.first.file, equals('world.json'));

    print('Got ${response.shallowCategories.length} shallow categories!');
  });

  test('test getCategory(ShallowKiteCategory category)', () async {
    final shallowResponse = await kiteClient.getAllShallowCategories();
    final worldCategoryShallow = shallowResponse.shallowCategories[0];
    expect(worldCategoryShallow.name, equals('World'));

    final worldCategory = await kiteClient.getCategory(worldCategoryShallow);
    expect(worldCategory.dataClusters.length, greaterThan(0));

    print('Top Story Today: ${worldCategory.dataClusters.first.title}');
  });
}
