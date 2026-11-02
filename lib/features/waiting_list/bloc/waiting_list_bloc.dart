// Loads and removes the current patient's waiting-list entries.
// The list is refreshed after an entry is removed.

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/repositories/waiting_list_repository.dart';
import 'waiting_list_event.dart';
import 'waiting_list_state.dart';

/// Coordinates waiting-list retrieval and leave actions.
class WaitingListBloc extends Bloc<WaitingListEvent, WaitingListState> {
  WaitingListBloc(this._repository) : super(const WaitingListState()) {
    on<WaitingListRequested>((event, emit) => _load(emit));
    on<WaitingListLeft>((event, emit) async {
      emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
      try {
        await _repository.leave(event.waitingId);
        await _load(emit);
      } on ApiException catch (error) {
        emit(
          state.copyWith(
            status: FeatureStatus.failure,
            errorMessage: error.message,
          ),
        );
      }
    });
  }
  final WaitingListRepository _repository;
  Future<void> _load(Emitter<WaitingListState> emit) async {
    emit(state.copyWith(status: FeatureStatus.loading, clearError: true));
    try {
      final entries = await _repository.getMyWaitingList();
      emit(state.copyWith(status: FeatureStatus.success, entries: entries));
    } on ApiException catch (error) {
      emit(
        state.copyWith(
          status: FeatureStatus.failure,
          errorMessage: error.message,
        ),
      );
    }
  }
}
