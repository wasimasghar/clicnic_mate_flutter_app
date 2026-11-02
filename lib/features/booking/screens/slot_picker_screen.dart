// Appointment day and time selection screen.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/empty_state_view.dart';
import '../../../widgets/common/error_state_view.dart';
import '../../../widgets/common/primary_button.dart';
import '../../../widgets/custom/day_selector.dart';
import '../../../widgets/custom/slot_chip.dart';

/// Slot picker whose dates and times are supplied by the caller.
class SlotPickerScreen extends StatelessWidget {
  const SlotPickerScreen({
    super.key,
    required this.days,
    required this.selectedDayIndex,
    required this.slots,
    required this.clinicName,
    required this.clinicArea,
    required this.onDaySelected,
    required this.onSlotSelected,
    required this.onContinue,
    this.selectedSlot,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.morningSlots,
    this.afternoonSlots,
    this.eveningSlots,
  });
  final List<String> days, slots;
  final int selectedDayIndex;
  final String clinicName, clinicArea;
  final ValueChanged<int> onDaySelected;
  final ValueChanged<String> onSlotSelected;
  final VoidCallback onContinue;
  final String? selectedSlot, errorMessage;
  final bool isLoading;
  final VoidCallback? onRetry;
  final List<String>? morningSlots, afternoonSlots, eveningSlots;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.extraLarge),

        children: [
          Text(AppStrings.slotPickerTitle, style: AppTextStyles.heading),
          const SizedBox(height: AppSpacing.large),
          Text(clinicName, style: AppTextStyles.sectionTitle),
          Text(clinicArea, style: AppTextStyles.caption),
          const SizedBox(height: AppSpacing.large),
          DaySelector(
            days: days,
            selectedIndex: selectedDayIndex,
            onSelected: onDaySelected,
          ),
          const SizedBox(height: AppSpacing.xxLarge),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage != null)
            ErrorStateView(message: errorMessage!, onRetry: onRetry ?? () {})
          else if (slots.isEmpty)
            const EmptyStateView(
              icon: Icons.schedule,

              title: AppStrings.emptySlotsTitle,
              message: AppStrings.emptySlotsMessage,
            )
          else ...[
            if ((morningSlots ?? slots).isNotEmpty)
              SlotGroup(
                title: AppStrings.morning,
                slots: morningSlots ?? slots,
                selectedSlot: selectedSlot,
                onSlotSelected: onSlotSelected,
              ),
            if ((afternoonSlots ?? slots).isNotEmpty)
              SlotGroup(
                title: AppStrings.afternoon,
                slots: afternoonSlots ?? slots,
                selectedSlot: selectedSlot,
                onSlotSelected: onSlotSelected,
              ),
            if ((eveningSlots ?? slots).isNotEmpty)
              SlotGroup(
                title: AppStrings.evening,
                slots: eveningSlots ?? slots,
                selectedSlot: selectedSlot,
                onSlotSelected: onSlotSelected,
              ),
          ],
          const SizedBox(height: AppSpacing.xxLarge),
          PrimaryButton(label: AppStrings.continueLabel, onPressed: onContinue),
        ],
      ),
    ),
  );
}

/// Time group with a wrapping collection of slot chips.
class SlotGroup extends StatelessWidget {
  const SlotGroup({
    super.key,
    required this.title,
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });
  final String title;
  final List<String> slots;
  final String? selectedSlot;
  final ValueChanged<String> onSlotSelected;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.large),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.small),
        Wrap(
          spacing: AppSpacing.small,
          children: slots
              .map(
                (slot) => SlotChip(
                  label: slot,
                  isSelected: selectedSlot == slot,
                  onTap: () => onSlotSelected(slot),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );
}
