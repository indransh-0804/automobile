import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:automobile/data/models/shift_model.dart';

class ShiftNotifier extends StateNotifier<ShiftState> {
  Timer? _timer;

  ShiftNotifier()
      : super(ShiftState(
          startTime: DateTime(2026, 3, 1, 9, 0),
          endTime: DateTime(2026, 3, 1, 17, 30),
          salesDuringShift: 3,
        ));

  void startShift() {
    state = ShiftState(
      isActive: true,
      startTime: DateTime.now(),
      elapsedDuration: Duration.zero,
      salesDuringShift: 0,
    );
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.isActive && state.startTime != null) {
        state = state.copyWith(
          elapsedDuration: DateTime.now().difference(state.startTime!),
        );
      }
    });
  }

  void endShift() {
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isActive: false, endTime: DateTime.now());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final shiftProvider =
    StateNotifierProvider<ShiftNotifier, ShiftState>((_) => ShiftNotifier());