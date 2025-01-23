import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/humidity_metrics.dart';

part 'humidity_dial_state.freezed.dart';

@freezed
class HumidityDialState with _$HumidityDialState {
  const factory HumidityDialState.initial() = _Initial;
  const factory HumidityDialState.loading() = _Loading;
  const factory HumidityDialState.loaded(HumidityMetrics metrics) = _Loaded;
  const factory HumidityDialState.error(String message) = _Error;
} 