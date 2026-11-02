// Search and retry events for the doctor directory.
// Text input has a dedicated event for debounced searching.

import 'package:equatable/equatable.dart';
import '../../../data/models/doctor_search_filters.dart';

/// Base type for doctor search actions.
sealed class DoctorSearchEvent extends Equatable {
  const DoctorSearchEvent();
  @override
  List<Object?> get props => [];
}

/// Loads directory filters and the first doctor results.
class DoctorSearchStarted extends DoctorSearchEvent {
  const DoctorSearchStarted();
}

/// Searches the directory after the user's input settles.
class DoctorSearchTextChanged extends DoctorSearchEvent {
  const DoctorSearchTextChanged(this.text);
  final String text;
  @override
  List<Object?> get props => [text];
}

/// Replaces active directory filters.
class DoctorSearchFiltersChanged extends DoctorSearchEvent {
  const DoctorSearchFiltersChanged(this.filters);
  final DoctorSearchFilters filters;
  @override
  List<Object?> get props => [filters];
}

/// Retries the most recent search request.
class DoctorSearchRetried extends DoctorSearchEvent {
  const DoctorSearchRetried();
}
