import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_summary_response.freezed.dart';
part 'get_summary_response.g.dart';

@freezed
sealed class GetSummaryResponse with _$GetSummaryResponse {
  const factory GetSummaryResponse({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'displaytitle') String? displayTitle,
    @JsonKey(name: 'namespace') WikipediaNamespace? namespace,
    @JsonKey(name: 'wikibase_item') String? wikiBaseItem,
    @JsonKey(name: 'titles') WikipediaTitle? titles,
    @JsonKey(name: 'pageid') int? pageId,
    @JsonKey(name: 'thumbnail') WikipediaImage? thumbnail,
    @JsonKey(name: 'originalimage') WikipediaImage? originalImage,
    @JsonKey(name: 'lang') String? lang,
    @JsonKey(name: 'dir') String? dir,
    @JsonKey(name: 'revision') String? revision,
    @JsonKey(name: 'tid') String? tid,
    @JsonKey(name: 'timestamp') String? timestamp,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'description_source') String? descriptionSource,
    @JsonKey(name: 'content_urls') WikipediaContentUrlType? contentUrls,
    @JsonKey(name: 'extract') String? articleSummary,
    @JsonKey(name: 'extract_html') String? extractHtml,
  }) = _GetSummaryResponse;

  factory GetSummaryResponse.fromJson(Map<String, Object?> json) => _$GetSummaryResponseFromJson(json);
}

extension SummaryConvenience on GetSummaryResponse {
  String? get thumbnailUrl => thumbnail?.sourceUrl;
}

@freezed
sealed class WikipediaContentUrlType with _$WikipediaContentUrlType {
  const factory WikipediaContentUrlType({
    @JsonKey(name: 'desktop') WikipediaContentUrl? desktop,
    @JsonKey(name: 'mobile') WikipediaContentUrl? mobile,
  }) = _WikipediaContentUrlType;

  factory WikipediaContentUrlType.fromJson(Map<String, Object?> json) => _$WikipediaContentUrlTypeFromJson(json);
}

@freezed
sealed class WikipediaContentUrl with _$WikipediaContentUrl {
  const factory WikipediaContentUrl({
    @JsonKey(name: 'page') String? page,
    @JsonKey(name: 'revisions') String? revisions,
    @JsonKey(name: 'edit') String? edit,
    @JsonKey(name: 'talk') String? talk,
  }) = _WikipediaContentUrl;

  factory WikipediaContentUrl.fromJson(Map<String, Object?> json) => _$WikipediaContentUrlFromJson(json);
}

@freezed
sealed class WikipediaImage with _$WikipediaImage {
  const factory WikipediaImage({
    @JsonKey(name: 'source') String? sourceUrl,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
  }) = _WikipediaImage;

  factory WikipediaImage.fromJson(Map<String, Object?> json) => _$WikipediaImageFromJson(json);
}

@freezed
sealed class WikipediaTitle with _$WikipediaTitle {
  const factory WikipediaTitle({
    @JsonKey(name: 'canonical') String? canonical,
    @JsonKey(name: 'normalized') String? normalized,
    @JsonKey(name: 'display') String? display,
  }) = _WikipediaTitle;

  factory WikipediaTitle.fromJson(Map<String, Object?> json) => _$WikipediaTitleFromJson(json);
}

@freezed
sealed class WikipediaNamespace with _$WikipediaNamespace {
  const factory WikipediaNamespace({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'text') String? text,
  }) = _WikipediaNamespace;

  factory WikipediaNamespace.fromJson(Map<String, Object?> json) => _$WikipediaNamespaceFromJson(json);
}

