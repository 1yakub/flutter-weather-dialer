/// Business logic component for managing the humidity dial state using the Cubit pattern.
/// This class handles state updates and business logic for the humidity dial feature.
///
/// Key responsibilities:
/// - Managing the humidity dial state
/// - Handling humidity metrics updates
/// - Emitting state changes to the UI
///
/// To extend this for other metrics:
/// 1. Create a new cubit class for your metric
/// 2. Update the state type and methods to match your metric
/// 3. Add any additional business logic needed
import 'package:flutter_bloc/flutter_bloc.dart';
import 'humidity_dial_state.dart';
import '../../domain/entities/humidity_metrics.dart';

/// Cubit class that manages the state of the humidity dial feature.
/// Extends [Cubit] with [HumidityDialState] as the state type.
class HumidityDialCubit extends Cubit<HumidityDialState> {
  /// Creates a new instance of [HumidityDialCubit] with an initial state.
  HumidityDialCubit() : super(const HumidityDialState.initial());

  /// Updates the humidity metrics and emits a new loaded state.
  ///
  /// Parameters:
  /// - [metrics]: The new humidity metrics to update the state with
  ///
  /// This method can be called whenever new humidity data is available,
  /// such as from a sensor reading or API response.
  void updateMetrics(HumidityMetrics metrics) {
    emit(HumidityDialState.loaded(metrics));
  }
}
