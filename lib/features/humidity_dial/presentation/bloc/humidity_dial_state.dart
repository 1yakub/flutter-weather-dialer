/// State management for the Humidity Dial feature using the Freezed package for
/// immutable state handling. This file defines the possible states of the humidity dial.
///
/// States:
/// - [initial]: Initial state when the widget is first created
/// - [loading]: State while fetching humidity data
/// - [loaded]: State when humidity data is successfully loaded
/// - [error]: State when an error occurs during data fetching
///
/// To extend this for other metrics:
/// 1. Create a new metrics entity in the domain layer
/// 2. Update the state class name and loaded state parameter
/// 3. Add any additional states needed for your use case
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/humidity_metrics.dart';

part 'humidity_dial_state.freezed.dart';

/// Union class representing all possible states of the humidity dial feature.
/// Generated using Freezed for type-safe state management.
@freezed
class HumidityDialState with _$HumidityDialState {
  /// Initial state when the widget is first created
  const factory HumidityDialState.initial() = _Initial;

  /// State while fetching humidity data
  const factory HumidityDialState.loading() = _Loading;

  /// State when humidity data is successfully loaded
  /// [metrics] contains the current and average humidity values
  const factory HumidityDialState.loaded(HumidityMetrics metrics) = _Loaded;

  /// State when an error occurs during data fetching
  /// [message] contains the error description
  const factory HumidityDialState.error(String message) = _Error;
}
