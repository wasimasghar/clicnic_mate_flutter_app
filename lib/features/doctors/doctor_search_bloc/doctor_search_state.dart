// State for doctor directory results and filter selections.
// Carries cities for location filters and messages for empty/error views.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/city.dart';
import '../../../data/models/doctor_search_filters.dart';
import '../../../data/models/doctor_summary.dart';

/// Holds doctor search results and current query state.
class DoctorSearchState extends Equatable {
  const DoctorSearchState({
    this.status = FeatureStatus.initial,
    this.cities = const [],
    this.doctors = const [],
    this.filters = const DoctorSearchFilters(),
    this.query = '',
    this.errorMessage,
  });
  final FeatureStatus status;
  final List<City> cities;
  final List<DoctorSummary> doctors;
  final DoctorSearchFilters filters;
  final String query;
  final String? errorMessage;
  DoctorSearchState copyWith({
    FeatureStatus? status,
    List<City>? cities,
    List<DoctorSummary>? doctors,
    DoctorSearchFilters? filters,
    String? query,
    String? errorMessage,
    bool clearError = false,
  }) => DoctorSearchState(
    status: status ?? this.status,
    cities: cities ?? this.cities,
    doctors: doctors ?? this.doctors,
    filters: filters ?? this.filters,
    query: query ?? this.query,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    status,
    cities,
    doctors,
    filters,
    query,
    errorMessage,
  ];
}
