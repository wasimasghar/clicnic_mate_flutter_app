// Loads availability and records the selected date and slot id.
// Slot data is fetched through DoctorRepository.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/doctor_repository.dart';
import 'slot_picker_event.dart';
import 'slot_picker_state.dart';

/// Coordinates slot picker availability and selections.
class SlotPickerBloc extends Bloc<SlotPickerEvent, SlotPickerState> {
  SlotPickerBloc(this._repository) : super(const SlotPickerState()) {
    on<SlotsRequested>((e, emit) async {
      emit(
        state.copyWith(
          status: FeatureStatus.loading,
          doctorId: e.doctorId,
          clearError: true,
        ),
      );
      try {
        final data = await _repository.getSlots(
          e.doctorId,
          dateFrom: e.dateFrom,
          timeOfDay: e.timeOfDay,
        );
        emit(
          state.copyWith(
            status: FeatureStatus.success,
            availability: data,
            selectedDate: data.days.isEmpty ? null : data.days.first.date,
            clearSelectedSlot: true,
          ),
        );
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
    on<SlotDaySelected>(
      (e, emit) =>
          emit(state.copyWith(selectedDate: e.date, clearSelectedSlot: true)),
    );
    on<SlotSelected>(
      (e, emit) => emit(state.copyWith(selectedSlotId: e.slotId)),
    );
  }
  final DoctorRepository _repository;
}
