// Patient waiting-list entries with slot offers and list states.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../widgets/common/empty_state_view.dart';
import '../../../widgets/common/error_state_view.dart';
import '../../../widgets/common/loading_view.dart';
import '../../../widgets/custom/waiting_list_tile.dart';

/// Waiting list with offer, leave, loading, empty, and error states.
class WaitingListScreen extends StatelessWidget {
  const WaitingListScreen({
    super.key,
    required this.doctorNames,
    required this.preferredDates,
    required this.slotOffered,
    required this.offeredTimes,
    required this.expiryTimes,
    required this.onBook,
    required this.onLeave,
    required this.onRetry,
    this.isLoading = false,
    this.errorMessage,
    this.waitingIds = const [],
    this.offeredSlotIds = const [],
  });
  final List<String> doctorNames, preferredDates, offeredTimes, expiryTimes;
  final List<bool> slotOffered;
  final ValueChanged<int> onBook, onLeave;
  final VoidCallback onRetry;
  final bool isLoading;
  final String? errorMessage;
  final List<String> waitingIds, offeredSlotIds;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppStrings.waitingListTitle)),

    body: isLoading
        ? const LoadingView()
        : errorMessage != null
        ? ErrorStateView(message: errorMessage!, onRetry: onRetry)
        : doctorNames.isEmpty
        ? const EmptyStateView(
            icon: Icons.hourglass_empty,

            title: AppStrings.waitingListTitle,
            message: AppStrings.emptyStateMessage,
          )
        : ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.extraLarge),

            itemCount: doctorNames.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.medium),

            itemBuilder: (_, index) => WaitingListTile(
              doctorName: doctorNames[index],
              preferredDate: preferredDates[index],
              isSlotOffered: slotOffered[index],
              offeredTime: offeredTimes[index],
              expiryTime: expiryTimes[index],
              onBook: () => onBook(index),
              onLeave: () => onLeave(index),
            ),
          ),
  );
}
