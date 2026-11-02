// Loads and filters doctor directory results with debounced text search.
// Restartable text events prevent stale searches replacing newer results.

import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/doctor_search_filters.dart';
import '../../../data/repositories/doctor_repository.dart';
import 'doctor_search_event.dart';
import 'doctor_search_state.dart';

/// Coordinates doctor directory search and filter requests.
class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  DoctorSearchBloc(this._repository) : super(const DoctorSearchState()) {
    on<DoctorSearchStarted>((e, emit) => _start(emit));
    on<DoctorSearchTextChanged>(
      _searchText,
      transformer: _debounceRestartable(const Duration(milliseconds: 400)),
    );
    on<DoctorSearchFiltersChanged>((e, emit) async {
      emit(state.copyWith(filters: e.filters));
      await _search(state.filters, emit);
    });
    on<DoctorSearchRetried>((e, emit) => _search(state.filters, emit));
  }
  final DoctorRepository _repository;
  Future<void> _start(Emitter<DoctorSearchState> emit) async {
    emit(state.copyWith(status: FeatureStatus.loading));
    try {
      // Start both requests together while preserving their concrete model types.
      final citiesRequest = _repository.getCities();
      final doctorsRequest = _repository.searchDoctors(state.filters);
      final cities = await citiesRequest;
      final doctors = await doctorsRequest;
      emit(
        state.copyWith(
          status: FeatureStatus.success,
          cities: cities,
          doctors: doctors,
          clearError: true,
        ),
      );
    } on ApiException catch (error) {
      _emitFailure(emit, error);
    }
  }

  Future<void> _searchText(
    DoctorSearchTextChanged event,
    Emitter<DoctorSearchState> emit,
  ) async {
    final filters = DoctorSearchFilters(
      specialty: state.filters.specialty,
      city: state.filters.city,
      area: state.filters.area,
      gender: state.filters.gender,
      language: state.filters.language,
      maxFee: state.filters.maxFee,
      minRating: state.filters.minRating,
      need: event.text.isEmpty ? null : event.text,
      sortBy: state.filters.sortBy,
      limit: state.filters.limit,
    );
    emit(state.copyWith(query: event.text, filters: filters));
    await _search(filters, emit);
  }

  Future<void> _search(
    DoctorSearchFilters filters,
    Emitter<DoctorSearchState> emit,
  ) async {
    emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
    try {
      final doctors = await _repository.searchDoctors(filters);
      emit(state.copyWith(status: FeatureStatus.success, doctors: doctors));
    } on ApiException catch (e) {
      _emitFailure(emit, e);
    }
  }

  void _emitFailure(Emitter<DoctorSearchState> emit, ApiException error) {
    final unavailable = error.message.contains('not available');
    emit(
      state.copyWith(
        status: unavailable ? FeatureStatus.success : FeatureStatus.failure,
        doctors: unavailable ? const [] : null,
        errorMessage: error.message,
      ),
    );
  }
}

EventTransformer<E> _debounceRestartable<E>(Duration duration) {
  return (events, mapper) =>
      restartable<E>().call(_debounce(events, duration), mapper);
}

Stream<E> _debounce<E>(Stream<E> events, Duration duration) {
  late StreamController<E> output;
  StreamSubscription<E>? subscription;
  Timer? timer;
  output = StreamController<E>(
    onListen: () {
      subscription = events.listen(
        (event) {
          timer?.cancel();
          timer = Timer(duration, () {
            if (!output.isClosed) output.add(event);
          });
        },
        onError: output.addError,
        onDone: () {
          timer?.cancel();
          output.close();
        },
      );
    },
    onCancel: () async {
      timer?.cancel();
      await subscription?.cancel();
    },
  );
  return output.stream;
}
