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


  test('test "On This Day" category incompatibility', () async {
    final shallowResponse = await kiteClient.getAllShallowCategories();
    final onThisDayShallow = shallowResponse.shallowCategories.where((cat) => cat.name == 'OnThisDay').toList();
    expect(onThisDayShallow.length, equals(1));

    // should throw. the "On This Day" category needs to be deserialized with a different class
    await expectLater(kiteClient.getCategory(onThisDayShallow.first), throwsA(anything));
  });

  test('ensure all categories deserialize', () async {
    final shallowResponse = await kiteClient.getAllShallowCategories();
    final shallowCategories = shallowResponse.shallowCategories.where((cat) => cat.name != 'OnThisDay').toList();

    final deepCategories = <KiteCategoryCluster>[];
    for (final shallowCategory in shallowCategories) {
      final deepCatResponse = await kiteClient.getCategory(shallowCategory);
      deepCategories.addAll(deepCatResponse.dataClusters);
    }

    expect(deepCategories.length, greaterThan(0));
    print('Deserialized ${deepCategories.length} stories across all categories');
  });
}
