// State for the patient's waiting-list entries.
// Includes operation status and readable request errors.

import 'package:equatable/equatable.dart';
import '../../../core/network/feature_status.dart';
import '../../../data/models/waiting_list_entry.dart';

/// Holds waiting-list rows and their load state.
class WaitingListState extends Equatable {
  const WaitingListState({
    this.status = FeatureStatus.initial,
    this.entries = const [],
    this.errorMessage,
  });
  final FeatureStatus status;
  final List<WaitingListEntry> entries;
  final String? errorMessage;
  WaitingListState copyWith({
    FeatureStatus? status,
    List<WaitingListEntry>? entries,
    String? errorMessage,
    bool clearError = false,
  }) => WaitingListState(
    status: status ?? this.status,
    entries: entries ?? this.entries,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
  @override
  List<Object?> get props => [status, entries, errorMessage];
}
