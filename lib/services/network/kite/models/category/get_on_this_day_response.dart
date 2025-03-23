import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_on_this_day_response.freezed.dart';
part 'get_on_this_day_response.g.dart';

@freezed
sealed class GetOnThisDayResponse with _$GetOnThisDayResponse {
  const factory GetOnThisDayResponse({
    @JsonKey(name: 'timestamp') required int timestamp,
    @JsonKey(name: 'events') required List<KiteHistoricalEvent> allEvents,
  }) = _GetOnThisDayResponse;

  factory GetOnThisDayResponse.fromJson(Map<String, Object?> json) => _$GetOnThisDayResponseFromJson(json);
}

extension OnThisDayResponseConvenience on GetOnThisDayResponse {
  List<KiteHistoricalEvent> get people => allEvents.where((event) => event.type == 'people').toList(growable: false);
  List<KiteHistoricalEvent> get historicalEvents => allEvents.where((event) => event.type == 'event').toList(growable: false);
}

@freezed
sealed class KiteHistoricalEvent with _$KiteHistoricalEvent {
  const factory KiteHistoricalEvent({
    @JsonKey(name: 'year') required String year,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'sort_year') required double sortYear,
    @JsonKey(name: 'type') required String type,
  }) = _KiteHistoricalEvent;

  factory KiteHistoricalEvent.fromJson(Map<String, Object?> json) => _$KiteHistoricalEventFromJson(json);
}
