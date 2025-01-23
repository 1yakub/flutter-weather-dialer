import 'package:flutter_bloc/flutter_bloc.dart';
import 'humidity_dial_state.dart';
import '../../domain/entities/humidity_metrics.dart';

class HumidityDialCubit extends Cubit<HumidityDialState> {
  HumidityDialCubit() : super(const HumidityDialState.initial());

  // Add methods for updating humidity metrics
  void updateMetrics(HumidityMetrics metrics) {
    emit(HumidityDialState.loaded(metrics));
  }
}
