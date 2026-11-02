// Conversational assistant with streaming-ready messages and optional results.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../data/models/chat_message.dart';
import '../../../widgets/common/error_state_view.dart';
import '../../../widgets/common/loading_view.dart';
import '../../../widgets/custom/assistant_status_row.dart';
import '../../../widgets/custom/chat_booking_card.dart';
import '../../../widgets/custom/chat_bubble.dart';
import '../../../widgets/custom/chat_doctor_card.dart';
import '../../../widgets/custom/chat_input_bar.dart';
import '../../../widgets/custom/health_disclaimer_banner.dart';
import '../../../widgets/custom/source_chips_row.dart';
import '../../../widgets/custom/suggestion_chips_row.dart';

/// Assistant conversation whose transcript and actions come from its caller.
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.messages,
    required this.messageAuthors,
    required this.suggestions,
    required this.sourceNames,
    required this.inputController,
    required this.onSend,
    required this.onSuggestionSelected,
    this.isSending = false,
    this.isWorking = false,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.statusMessage = AppStrings.searchingDoctors,
    this.doctorInitials,
    this.doctorName,
    this.doctorSpecialty,
    this.doctorFee,
    this.onViewDoctor,
    this.bookingSummary,
    this.isBooked = false,
    this.onConfirmBooking,
    this.onChangeTime,
    this.chatMessages = const [],
    this.showDisclaimer = false,
    this.onViewDoctorId,
    this.onNewConversation,
  });
  final List<String> messages, messageAuthors, suggestions, sourceNames;
  final TextEditingController inputController;
  final VoidCallback onSend;
  final ValueChanged<String> onSuggestionSelected;
  final bool isSending, isWorking, isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String statusMessage;
  final String? doctorInitials, doctorName, doctorSpecialty, bookingSummary;
  final int? doctorFee;
  final VoidCallback? onViewDoctor, onConfirmBooking, onChangeTime;
  final bool isBooked;
  final List<ChatMessage> chatMessages;
  final bool showDisclaimer;
  final ValueChanged<String>? onViewDoctorId;
  final VoidCallback? onNewConversation;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

/// Keeps the newest streamed chat content visible while the assistant responds.
class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    _scrollToLatest();
  }

  @override
  void didUpdateWidget(covariant ChatScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.chatMessages, widget.chatMessages)) {
      _scrollToLatest();
    }
  }

  void _scrollToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.messages;
    final messageAuthors = widget.messageAuthors;
    final suggestions = widget.suggestions;
    final sourceNames = widget.sourceNames;
    final inputController = widget.inputController;
    final onSend = widget.onSend;
    final onSuggestionSelected = widget.onSuggestionSelected;
    final isSending = widget.isSending;
    final isWorking = widget.isWorking;
    final isLoading = widget.isLoading;
    final errorMessage = widget.errorMessage;
    final onRetry = widget.onRetry;
    final statusMessage = widget.statusMessage;
    final doctorInitials = widget.doctorInitials;
    final doctorName = widget.doctorName;
    final doctorSpecialty = widget.doctorSpecialty;
    final doctorFee = widget.doctorFee;
    final onViewDoctor = widget.onViewDoctor;
    final bookingSummary = widget.bookingSummary;
    final isBooked = widget.isBooked;
    final onConfirmBooking = widget.onConfirmBooking;
    final onChangeTime = widget.onChangeTime;
    final chatMessages = widget.chatMessages;
    final showDisclaimer = widget.showDisclaimer;
    final onViewDoctorId = widget.onViewDoctorId;
    final onNewConversation = widget.onNewConversation;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(
          children: [
            Text(AppStrings.assistantTitle, style: AppTextStyles.sectionTitle),
            const SizedBox(width: AppSpacing.small),
            const Icon(
              Icons.circle,
              color: AppColors.success,
              size: AppSpacing.smallIconSize,
            ),
            const SizedBox(width: AppSpacing.extraSmall),
            Text(AppStrings.online, style: AppTextStyles.caption),
          ],
        ),
        actions: [
          if (onNewConversation != null)
            IconButton(
              tooltip: 'New conversation',
              onPressed: onNewConversation,
              icon: const Icon(Icons.add_comment_outlined),
            ),
        ],
      ),
      body: Column(
        children: [
          if (showDisclaimer) const HealthDisclaimerBanner(),

          Expanded(
            child: isLoading
                ? const LoadingView()
                : errorMessage != null
                ? ErrorStateView(
                    message: errorMessage,

                    onRetry: onRetry ?? () {},
                  )
                : ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.extraLarge),

                    children: [
                      if (chatMessages.isEmpty &&
                          messages.isEmpty &&
                          suggestions.isNotEmpty)
                        SuggestionChipsRow(
                          suggestions: suggestions,
                          onSelected: onSuggestionSelected,
                        ),
                      if (chatMessages.isNotEmpty)
                        for (final message in chatMessages) ...[
                          if (message.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.medium,
                              ),
                              child: ChatBubble(
                                text: message.text,
                                isUser: message.isUser,
                              ),
                            ),
                          if (message.isStreaming)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.small,
                              ),
                              child: AssistantStatusRow(
                                message:
                                    message.statusText ??
                                    AppStrings.assistantThinking,
                              ),
                            ),
                          for (final doctor in message.doctorCards)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.small,
                              ),
                              child: ChatDoctorCard(
                                initials: doctor.fullName
                                    .trim()
                                    .split(RegExp(r'\s+'))
                                    .take(2)
                                    .map((part) => part.isEmpty ? '' : part[0])
                                    .join()
                                    .toUpperCase(),
                                name: doctor.fullName,
                                specialty: doctor.specialty,
                                fee: doctor.consultationFee.round(),
                                onViewProfile: () =>
                                    onViewDoctorId?.call(doctor.id),
                              ),
                            ),
                          if (message.bookingCard != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.small,
                              ),
                              child: ChatBookingCard(
                                summary:
                                    '${message.bookingCard!.doctorName} · ${message.bookingCard!.day}, ${message.bookingCard!.date} · ${message.bookingCard!.startTime} · ${message.bookingCard!.clinic}, ${message.bookingCard!.area} · Rs ${message.bookingCard!.consultationFee.round()}',
                                isBooked: message.bookingCard!.kind != 'quote',
                                statusText: _bookingStatus(
                                  message.bookingCard!.kind,
                                ),
                                onConfirm: onConfirmBooking ?? () {},
                                onChangeTime: onChangeTime ?? () {},
                              ),
                            ),
                          if (message.sources.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppSpacing.small,
                              ),
                              child: SourceChipsRow(
                                sources: message.sources
                                    .map((source) => source.title)
                                    .toList(),
                              ),
                            ),
                        ],
                      if (chatMessages.isEmpty)
                        for (var index = 0; index < messages.length; index++)
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.medium,
                            ),

                            child: ChatBubble(
                              text: messages[index],
                              isUser:
                                  messageAuthors[index] ==
                                  AppStrings.chatUserAuthor,
                            ),
                          ),

                      if (chatMessages.isEmpty && isWorking)
                        AssistantStatusRow(message: statusMessage),
                      if (doctorName != null &&
                          doctorSpecialty != null &&
                          doctorInitials != null &&
                          doctorFee != null)
                        ChatDoctorCard(
                          initials: doctorInitials,

                          name: doctorName,
                          specialty: doctorSpecialty,
                          fee: doctorFee,
                          onViewProfile: onViewDoctor ?? () {},
                        ),
                      if (bookingSummary != null)
                        ChatBookingCard(
                          summary: bookingSummary,

                          isBooked: isBooked,
                          onConfirm: onConfirmBooking ?? () {},
                          onChangeTime: onChangeTime ?? () {},
                        ),
                      if (sourceNames.isNotEmpty)
                        SourceChipsRow(sources: sourceNames),
                    ],
                  ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.medium),
              child: ChatInputBar(
                controller: inputController,
                isSending: isSending,
                onSend: onSend,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _bookingStatus(String kind) {
  switch (kind) {
    case 'cancelled':
      return 'Cancelled';
    case 'rescheduled':
      return 'Rescheduled';
    default:
      return AppStrings.statusBooked;
  }
}
