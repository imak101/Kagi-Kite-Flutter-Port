import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_categories_response.freezed.dart';
part 'get_categories_response.g.dart';

@freezed
sealed class GetShallowCategoriesResponse with _$GetShallowCategoriesResponse {
  const factory GetShallowCategoriesResponse({
    @JsonKey(name: 'timestamp') required int timestamp,
    @JsonKey(name: 'categories') required List<ShallowKiteCategory> shallowCategories,
  }) = _GetShallowCategoriesResponse;

  factory GetShallowCategoriesResponse.fromJson(Map<String, Object?> json) => _$GetShallowCategoriesResponseFromJson(json);
}

@freezed
sealed class ShallowKiteCategory with _$ShallowKiteCategory {
  const factory ShallowKiteCategory({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'file') required String file,
  }) = _ShallowKiteCategory;

  factory ShallowKiteCategory.fromJson(Map<String, Object?> json) => _$ShallowKiteCategoryFromJson(json);
}

