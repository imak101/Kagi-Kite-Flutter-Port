import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'get_category_response.freezed.dart';
part 'get_category_response.g.dart';


@freezed
sealed class GetCategoryResponse with _$GetCategoryResponse {
  const factory GetCategoryResponse({
    @JsonKey(name: 'category') required String categoryName,
    @JsonKey(name: 'timestamp') required int timestamp,
    @JsonKey(name: 'read') required int readCount,
    @JsonKey(name: 'clusters') required List<KiteCategoryCluster> dataClusters,
  }) = _GetCategoryResponse;

  factory GetCategoryResponse.fromJson(Map<String, Object?> json) => _$GetCategoryResponseFromJson(json);
}

// implement extra logic for type-checking these values due to an API bug
extension KiteApiPatch on KiteCategoryCluster {
  List<String> _checkTypeAndCast(dynamic field) =>
      field is List ? List<String>.from(field) : List<String>.empty();

  List<String> get internationalReactions => _checkTypeAndCast(internationalReactionsDynamic);
  List<String> get timeline => _checkTypeAndCast(timelineDynamic);
  List<String> get technicalDetails => _checkTypeAndCast(technicalDetailsDynamic);
  List<String> get userActionItems => _checkTypeAndCast(userActionItemsDynamic);
  List<String> get userExperienceImpact => _checkTypeAndCast(userExperienceImpactDynamic);
}

@freezed
sealed class KiteCategoryCluster with _$KiteCategoryCluster {
  const factory KiteCategoryCluster({
    @JsonKey(name: 'cluster_number') required int clusterNumber,
    @JsonKey(name: 'unique_domains') required int uniqueDomains,
    @JsonKey(name: 'number_of_titles') required int numberOfTitles,
    @JsonKey(name: 'category') required String category,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'short_summary') required String shortSummary,
    @JsonKey(name: 'did_you_know') required String didYouKnow,
    @JsonKey(name: 'talking_points') required List<String> talkingPoints,
    @JsonKey(name: 'quote') required String quote,
    @JsonKey(name: 'quote_author') required String quoteAuthor,
    @JsonKey(name: 'quote_source_url') required String quoteSourceUrl,
    @JsonKey(name: 'quote_source_domain') required String quoteSourceDomain,
    @JsonKey(name: 'location') required String location,
    @JsonKey(name: 'perspectives') required List<KitePerspective> perspectives,
    @JsonKey(name: 'emoji') required String emoji,
    @JsonKey(name: 'geopolitical_context') required String geopoliticalContext,
    @JsonKey(name: 'historical_background') required String historicalBackground,

    // TODO: Revert all commented fields and delete extension class when API is patched
    // @JsonKey(name: 'international_reactions') required List<String> internationalReactions,
    @Deprecated('Use typed `internationalReactions`')
    @JsonKey(name: 'international_reactions') required dynamic internationalReactionsDynamic,

    @JsonKey(name: 'humanitarian_impact') required String humanitarianImpact,
    @JsonKey(name: 'economic_implications') required String economicImplications,

    // @JsonKey(name: 'timeline') required List<String> timeline
    @Deprecated('Use typed `timeline`')
    @JsonKey(name: 'timeline') required dynamic timelineDynamic,

    @JsonKey(name: 'future_outlook') required String futureOutlook,
    @JsonKey(name: 'key_players') required List<dynamic> keyPlayers,

    // @JsonKey(name: 'technical_details') required List<String> technicalDetails,
    @Deprecated('Use typed `technicalDetails`')
    @JsonKey(name: 'technical_details') required dynamic technicalDetailsDynamic,

    @JsonKey(name: 'business_angle_text') required String businessAngleText,
    @JsonKey(name: 'business_angle_points') required List<String> businessAnglePoints,

    // @JsonKey(name: 'user_action_items') required String userActionItems,
    @Deprecated('Use typed `userActionItems`')
    @JsonKey(name: 'user_action_items') required dynamic userActionItemsDynamic,

    @JsonKey(name: 'scientific_significance',) required List<dynamic> scientificSignificance,
    @JsonKey(name: 'travel_advisory') required List<dynamic> travelAdvisory,
    @JsonKey(name: 'destination_highlights') required String destinationHighlights,
    @JsonKey(name: 'culinary_significance') required String culinarySignificance,
    @JsonKey(name: 'performance_statistics') required List<dynamic> performanceStatistics,
    @JsonKey(name: 'league_standings') required String leagueStandings,
    @JsonKey(name: 'diy_tips') required String diyTips,
    @JsonKey(name: 'design_principles') required String designPrinciples,

    // @JsonKey(name: 'user_experience_impact') required String userExperienceImpact,
    @Deprecated('Use typed `userExperienceImpact`')
    @JsonKey(name: 'user_experience_impact') required dynamic userExperienceImpactDynamic,

    @JsonKey(name: 'gameplay_mechanics') required List<dynamic> gameplayMechanics,
    @JsonKey(name: 'industry_impact') required List<String> industryImpact,
    @JsonKey(name: 'technical_specifications') required String technicalSpecifications,
    @JsonKey(name: 'articles') required List<KiteArticle> articles,
    @JsonKey(name: 'domains') required List<KitePublisher> publishers,
  }) = _KiteCategoryCluster;

  // todo: unused? keyPlayers, scientificSignificance, travelAdvisory, performanceStatistics, gameplayMechanics

  factory KiteCategoryCluster.fromJson(Map<String, Object?> json) => _$KiteCategoryClusterFromJson(json);
}

@freezed
sealed class KitePublisher with _$KitePublisher {
  const factory KitePublisher({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'favicon') required String faviconUrl,
  }) = _KitePublisher;

  factory KitePublisher.fromJson(Map<String, Object?> json) => _$KitePublisherFromJson(json);
}

@freezed
sealed class KiteArticle with _$KiteArticle {
  const factory KiteArticle({
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'link') required String link,
    @JsonKey(name: 'domain') required String domain,
    @JsonKey(name: 'date') required String iso8601Date,
    @JsonKey(name: 'image') required String imageUrl,
    @JsonKey(name: 'image_caption') required String imageCaption,
  }) = _KiteArticle;

  factory KiteArticle.fromJson(Map<String, Object?> json) => _$KiteArticleFromJson(json);
}

@freezed
sealed class KitePerspective with _$KitePerspective {
  const factory KitePerspective({
    @JsonKey(name: 'text') required String text,
    @JsonKey(name: 'sources') required List<KiteSource> sources,
  }) = _KitePerspective;

  factory KitePerspective.fromJson(Map<String, Object?> json) => _$KitePerspectiveFromJson(json);
}

@freezed
sealed class KiteSource with _$KiteSource {
  const factory KiteSource({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _KiteSource;

  factory KiteSource.fromJson(Map<String, Object?> json) => _$KiteSourceFromJson(json);
}