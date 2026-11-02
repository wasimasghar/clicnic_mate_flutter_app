// State for availability, selected clinic day, and selected slot.
// Backend slot identifiers are retained for quote and booking requests.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/doctor_slots.dart';

/// Holds available slot days and current selections.
class SlotPickerState extends Equatable {
  const SlotPickerState({
    this.status = FeatureStatus.initial,
    this.doctorId,
    this.availability,
    this.selectedDate,
    this.selectedSlotId,
    this.errorMessage,
  });
  final FeatureStatus status;
  final String? doctorId, selectedDate, selectedSlotId, errorMessage;
  final DoctorSlots? availability;
  List<SlotDay> get days => availability?.days ?? const [];
  SlotPickerState copyWith({
    FeatureStatus? status,
    String? doctorId,
    DoctorSlots? availability,
    String? selectedDate,
    String? selectedSlotId,
    String? errorMessage,
    bool clearError = false,
    bool clearSelectedSlot = false,
  }) => SlotPickerState(
    status: status ?? this.status,
    doctorId: doctorId ?? this.doctorId,
    availability: availability ?? this.availability,
    selectedDate: selectedDate ?? this.selectedDate,
    selectedSlotId: clearSelectedSlot
        ? null
        : selectedSlotId ?? this.selectedSlotId,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    status,
    doctorId,
    availability,
    selectedDate,
    selectedSlotId,
    errorMessage,
  ];
}
