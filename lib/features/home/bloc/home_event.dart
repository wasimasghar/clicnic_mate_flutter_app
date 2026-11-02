// Events that load or refresh the home dashboard.
// User actions remain separate from dashboard rendering.

import 'package:equatable/equatable.dart';

/// Base type for home dashboard requests.
sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

/// Loads dashboard data for first display.
class HomeRequested extends HomeEvent {
  const HomeRequested();
}

/// Reloads dashboard data after a refresh action.
class HomeRefreshed extends HomeEvent {
  const HomeRefreshed();
}
