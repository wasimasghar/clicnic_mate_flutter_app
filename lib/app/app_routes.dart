// Route names and route builders for the ClinicMate user interface.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/network/feature_status.dart';
import '../data/models/doctor_search_filters.dart';
import '../data/models/doctor_slots.dart';
import '../data/models/appointment.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/doctor_repository.dart';
import '../data/repositories/appointment_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../data/repositories/waiting_list_repository.dart';
import '../features/chat/bloc/chat_bloc.dart';
import '../features/chat/bloc/chat_event.dart';
import '../features/chat/bloc/chat_state.dart';
import '../features/appointments/my_appointments_bloc/my_appointments_bloc.dart';
import '../features/appointments/my_appointments_bloc/my_appointments_event.dart';
import '../features/appointments/my_appointments_bloc/my_appointments_state.dart';
import '../features/appointments/reschedule_bloc/reschedule_bloc.dart';
import '../features/appointments/reschedule_bloc/reschedule_event.dart';
import '../features/appointments/reschedule_bloc/reschedule_state.dart';
import '../features/appointments/write_review_bloc/write_review_bloc.dart';
import '../features/appointments/write_review_bloc/write_review_event.dart';
import '../features/appointments/write_review_bloc/write_review_state.dart';
import '../features/waiting_list/bloc/waiting_list_bloc.dart';
import '../features/waiting_list/bloc/waiting_list_event.dart';
import '../features/waiting_list/bloc/waiting_list_state.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/profile/bloc/profile_event.dart';
import '../features/profile/bloc/profile_state.dart';
import '../features/auth/sign_in_bloc/sign_in_bloc.dart';
import '../features/auth/sign_in_bloc/sign_in_event.dart';
import '../features/auth/sign_in_bloc/sign_in_state.dart';
import '../features/auth/sign_up_bloc/sign_up_bloc.dart';
import '../features/auth/sign_up_bloc/sign_up_event.dart';
import '../features/auth/sign_up_bloc/sign_up_state.dart';
import '../features/auth/session_bloc/session_bloc.dart';
import '../features/auth/session_bloc/session_state.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/home/bloc/home_event.dart';
import '../features/home/bloc/home_state.dart';
import '../features/doctors/doctor_search_bloc/doctor_search_bloc.dart';
import '../features/doctors/doctor_search_bloc/doctor_search_event.dart';
import '../features/doctors/doctor_search_bloc/doctor_search_state.dart';
import '../features/doctors/doctor_profile_bloc/doctor_profile_bloc.dart';
import '../features/doctors/doctor_profile_bloc/doctor_profile_event.dart';
import '../features/doctors/doctor_profile_bloc/doctor_profile_state.dart';
import '../features/booking/slot_picker_bloc/slot_picker_bloc.dart';
import '../features/booking/slot_picker_bloc/slot_picker_event.dart';
import '../features/booking/slot_picker_bloc/slot_picker_state.dart';
import '../features/booking/booking_bloc/booking_bloc.dart';
import '../features/booking/booking_bloc/booking_event.dart';
import '../features/booking/booking_bloc/booking_state.dart';
import '../widgets/common/loading_view.dart';
import '../widgets/common/error_state_view.dart';
import '../core/constants/app_strings.dart';
import '../core/theme/app_colors.dart';
import '../features/splash/screens/startup_splash_gate.dart';
import '../features/auth/screens/sign_in_screen.dart';
import '../features/auth/screens/sign_up_screen.dart';
import '../features/auth/screens/otp_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/doctors/screens/doctor_search_screen.dart';
import '../features/doctors/screens/doctor_profile_screen.dart';
import '../features/booking/screens/slot_picker_screen.dart';
import '../features/booking/screens/booking_confirm_screen.dart';
import '../features/booking/screens/booking_success_screen.dart';
import '../features/main_shell/screens/main_shell_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/appointments/screens/my_appointments_screen.dart';
import '../features/appointments/screens/appointment_detail_screen.dart';
import '../features/appointments/screens/write_review_screen.dart';
import '../features/waiting_list/screens/waiting_list_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';

/// Named app destinations and their initial UI compositions.
class AppRoutes {
  AppRoutes._();
  static const String splash = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String otp = '/otp';
  static const String mainShell = '/app';
  static const String home = mainShell;
  static const String doctorSearch = '/doctors';
  static const String doctorProfile = '/doctor-profile';
  static const String slotPicker = '/slots';
  static const String bookingConfirm = '/booking-confirm';
  static const String bookingSuccess = '/booking-success';
  static const String chat = '/chat';
  static const String appointments = '/appointments';
  static const String appointmentDetail = '/appointment-detail';
  static const String writeReview = '/write-review';
  static const String waitingList = '/waiting-list';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const StartupSplashGate(
      homeRoute: mainShell,
      signInRoute: signIn,
    ),
    signIn: (context) => _buildSignIn(context),
    signUp: (context) => _buildSignUp(context),
    otp: (context) => _buildOtp(context),
    mainShell: (context) => _buildMainShell(context),
    doctorSearch: (context) => _buildDoctorSearch(context),
    doctorProfile: (context) => _buildDoctorProfile(context),
    slotPicker: (context) => _buildSlotPicker(context),
    bookingConfirm: (context) => _buildBookingConfirm(context),
    bookingSuccess: (context) => _buildBookingSuccess(context),
    chat: (context) => _buildChat(context),
    appointments: (context) => _buildAppointments(context),
    appointmentDetail: (context) => _buildAppointmentDetail(context),
    writeReview: (context) => _buildWriteReview(context),
    waitingList: (context) => _buildWaitingList(context),
    profile: (context) => _buildProfile(context),
    editProfile: (context) => _buildEditProfile(context),
  };

  static MainShellScreen _buildMainShell(BuildContext context) =>
      MainShellScreen(
        homeScreen: _buildHome(context),
        doctorsScreen: _buildDoctorSearch(context),
        assistantScreen: _buildChat(context),
        appointmentsScreen: _buildAppointments(context),
        profileScreen: _buildProfile(context),
      );

  static Widget _buildHome(BuildContext context) => BlocProvider(
    create: (context) => HomeBloc(
      context.read<DoctorRepository>(),
      context.read<AppointmentRepository>(),
      context.read<AuthRepository>(),
    )..add(const HomeRequested()),
    child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == FeatureStatus.loading ||
            state.status == FeatureStatus.initial) {
          return const LoadingView();
        }
        if (state.status == FeatureStatus.failure) {
          return ErrorStateView(
            message: state.errorMessage ?? 'Unable to load home.',
            onRetry: () => context.read<HomeBloc>().add(const HomeRefreshed()),
          );
        }
        return HomeScreen(
          specialtyNames: state.specialties.map((item) => item.name).toList(),
          specialtyIcons: List.filled(
            state.specialties.length,
            Icons.medical_services_outlined,
          ),
          hasUpcomingAppointment: state.upcomingAppointment != null,
          onOpenSearch: () => Navigator.pushNamed(context, doctorSearch),
          onOpenAssistant: () => Navigator.pushNamed(context, chat),
          onRetry: () => context.read<HomeBloc>().add(const HomeRefreshed()),
        );
      },
    ),
  );

  static Widget _buildDoctorSearch(BuildContext context) => BlocProvider(
    create: (context) =>
        DoctorSearchBloc(context.read<DoctorRepository>())
          ..add(const DoctorSearchStarted()),
    child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
      builder: (context, state) {
        if (state.status == FeatureStatus.loading ||
            state.status == FeatureStatus.initial) {
          return const LoadingView();
        }
        final unavailable =
            state.errorMessage?.contains('not available') == true;
        if (state.status == FeatureStatus.failure && !unavailable) {
          return ErrorStateView(
            message: state.errorMessage!,
            onRetry: () => context.read<DoctorSearchBloc>().add(
              const DoctorSearchRetried(),
            ),
          );
        }
        final doctors = state.doctors;
        return DoctorSearchScreen(
          initials: doctors.map<String>((d) => _initials(d.fullName)).toList(),
          doctorNames: doctors.map((d) => d.fullName).toList(),
          specialties: doctors.map((d) => d.specialty).toList(),
          ratings: doctors.map((d) => d.rating.toStringAsFixed(1)).toList(),
          fees: doctors.map((d) => d.consultationFee.round()).toList(),
          clinics: doctors
              .map((d) => d.clinics.isEmpty ? '' : d.clinics.first.clinic)
              .toList(),
          areas: doctors
              .map((d) => d.clinics.isEmpty ? '' : d.clinics.first.area)
              .toList(),
          nextTimes: doctors.map((d) => d.nextAvailable ?? '').toList(),
          onDoctorTap: (index) => Navigator.pushNamed(
            context,
            doctorProfile,
            arguments: doctors[index].id,
          ),
          onSearchChanged: (text) => context.read<DoctorSearchBloc>().add(
            DoctorSearchTextChanged(text),
          ),
          onRetry: () =>
              context.read<DoctorSearchBloc>().add(const DoctorSearchRetried()),
          emptyMessage: unavailable ? state.errorMessage : null,
          sortValue: state.filters.sortBy == 'fee_low'
              ? AppStrings.sortFeeLowHigh
              : state.filters.sortBy == 'rating'
              ? AppStrings.sortRatingHigh
              : AppStrings.sortRelevance,
          selectedFilters: state.filters.gender == 'female'
              ? const [AppStrings.filterFemaleDoctor]
              : const [],
          onFilterChanged: (label) {
            if (label == AppStrings.filterFemaleDoctor) {
              final filters = state.filters;
              context.read<DoctorSearchBloc>().add(
                DoctorSearchFiltersChanged(
                  DoctorSearchFilters(
                    specialty: filters.specialty,
                    city: filters.city,
                    area: filters.area,
                    gender: filters.gender == 'female' ? null : 'female',
                    language: filters.language,
                    maxFee: filters.maxFee,
                    minRating: filters.minRating,
                    need: filters.need,
                    sortBy: filters.sortBy,
                    limit: filters.limit,
                  ),
                ),
              );
            }
          },
          onSortChanged: (sort) => context.read<DoctorSearchBloc>().add(
            DoctorSearchFiltersChanged(_sortFilter(sort, state.filters)),
          ),
        );
      },
    ),
  );

  static Widget _buildDoctorProfile(BuildContext context) {
    final doctorId = ModalRoute.of(context)?.settings.arguments as String?;
    if (doctorId == null) {
      return const ErrorStateView(
        message: 'Doctor not found.',
        onRetry: _emptyAction,
      );
    }
    return BlocProvider(
      create: (context) =>
          DoctorProfileBloc(context.read<DoctorRepository>())
            ..add(DoctorProfileRequested(doctorId)),
      child: BlocBuilder<DoctorProfileBloc, DoctorProfileState>(
        builder: (context, state) {
          if (state.status == FeatureStatus.loading ||
              state.status == FeatureStatus.initial) {
            return const LoadingView();
          }
          if (state.status == FeatureStatus.failure || state.profile == null) {
            return ErrorStateView(
              message: state.errorMessage ?? 'Doctor not found.',
              onRetry: () => context.read<DoctorProfileBloc>().add(
                DoctorProfileRequested(doctorId),
              ),
            );
          }
          final p = state.profile!;
          return DoctorProfileScreen(
            doctorName: p.fullName,
            specialty: p.specialty,
            qualifications: p.qualifications ?? '',
            experience: '${p.experienceYears} years experience',
            rating: p.rating.toStringAsFixed(1),
            reviewCount: p.reviewCount,
            fee: p.consultationFee.round(),
            about: p.about ?? '',
            patientSummary: p.reviewSummary ?? '',
            weeklyDays: p.weeklySchedule.map((t) => t.day).toList(),
            weeklyHours: p.weeklySchedule
                .map((t) => '${t.start} - ${t.end}')
                .toList(),
            reviewAuthors: p.latestReviews.map((r) => r.reviewerName).toList(),
            reviewRatings: p.latestReviews
                .map((r) => r.rating.toStringAsFixed(1))
                .toList(),
            reviewTexts: p.latestReviews.map((r) => r.comment ?? '').toList(),
            onBook: () =>
                Navigator.pushNamed(context, slotPicker, arguments: p.id),
          );
        },
      ),
    );
  }

  static Widget _buildSlotPicker(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final argumentMap = arguments is Map ? arguments : null;
    final isRescheduling = argumentMap != null;
    final doctorId = argumentMap == null
        ? arguments as String?
        : argumentMap['doctorId'] as String?;
    final appointmentId = argumentMap?['appointmentId'] as String?;
    final rescheduleBloc = argumentMap?['rescheduleBloc'] as RescheduleBloc?;
    final appointmentsBloc =
        argumentMap?['appointmentsBloc'] as MyAppointmentsBloc?;
    if (doctorId == null) {
      return const ErrorStateView(
        message: 'Doctor not found.',
        onRetry: _emptyAction,
      );
    }
    return BlocProvider(
      create: (context) =>
          SlotPickerBloc(context.read<DoctorRepository>())
            ..add(SlotsRequested(doctorId)),
      child: BlocBuilder<SlotPickerBloc, SlotPickerState>(
        builder: (context, state) {
          if (state.status == FeatureStatus.loading ||
              state.status == FeatureStatus.initial) {
            return const LoadingView();
          }
          if (state.status == FeatureStatus.failure) {
            return ErrorStateView(
              message: state.errorMessage ?? 'Unable to load times.',
              onRetry: () =>
                  context.read<SlotPickerBloc>().add(SlotsRequested(doctorId)),
            );
          }
          final days = state.days;
          final selectedDay =
              _firstWhereOrNull(
                days,
                (day) => day.date == state.selectedDate,
              ) ??
              (days.isEmpty ? null : days.first);
          final selectedTimes = selectedDay?.times ?? const <SlotTime>[];
          return SlotPickerScreen(
            days: days.map((day) => '${day.day} ${day.date}').toList(),
            selectedDayIndex: selectedDay == null
                ? 0
                : days.indexOf(selectedDay),
            slots: selectedTimes.map((slot) => slot.time).toList(),
            clinicName: selectedDay?.clinic ?? '',
            clinicArea:
                '${selectedDay?.area ?? ''}, ${selectedDay?.city ?? ''}',
            morningSlots: _timesForPeriod(selectedTimes, 0),
            afternoonSlots: _timesForPeriod(selectedTimes, 1),
            eveningSlots: _timesForPeriod(selectedTimes, 2),
            selectedSlot: _firstWhereOrNull(
              selectedTimes,
              (slot) => slot.slotId == state.selectedSlotId,
            )?.time,
            onDaySelected: (index) => context.read<SlotPickerBloc>().add(
              SlotDaySelected(days[index].date),
            ),
            onSlotSelected: (time) {
              final slot = _firstWhereOrNull(
                selectedTimes,
                (entry) => entry.time == time,
              );
              if (slot != null) {
                context.read<SlotPickerBloc>().add(SlotSelected(slot.slotId));
              }
            },
            onRetry: () =>
                context.read<SlotPickerBloc>().add(SlotsRequested(doctorId)),
            onContinue: () {
              final slotId = state.selectedSlotId;
              if (slotId == null) return;
              if (isRescheduling &&
                  appointmentId != null &&
                  rescheduleBloc != null) {
                rescheduleBloc.add(RescheduleSlotChosen(appointmentId, slotId));
                Navigator.pushNamed(
                  context,
                  bookingConfirm,
                  arguments: {
                    'slotId': slotId,
                    'rescheduleBloc': rescheduleBloc,
                    'appointmentsBloc': appointmentsBloc,
                  },
                );
              } else {
                Navigator.pushNamed(context, bookingConfirm, arguments: slotId);
              }
            },
          );
        },
      ),
    );
  }

  static Widget _buildBookingConfirm(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map && arguments['rescheduleBloc'] is RescheduleBloc) {
      return _buildRescheduleConfirm(context, arguments);
    }
    final slotId = arguments as String?;
    if (slotId == null) {
      return const ErrorStateView(
        message: 'Appointment time not found.',
        onRetry: _emptyAction,
      );
    }
    final reasonController = TextEditingController();
    return BlocProvider(
      create: (context) => BookingBloc(
        context.read<DoctorRepository>(),
        context.read<AppointmentRepository>(),
        slotId: slotId,
      )..add(BookingQuoteRequested(slotId)),
      child: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.slotTaken) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      'This time was just booked by someone else, please pick another',
                ),
              ),
            );
          }
          if (state.appointment != null) {
            Navigator.pushReplacementNamed(
              context,
              bookingSuccess,
              arguments: state.appointment,
            );
          }
        },
        builder: (context, state) {
          if (state.status == FeatureStatus.loading && state.quote == null) {
            return const LoadingView();
          }
          if (state.status == FeatureStatus.failure && state.quote == null) {
            return ErrorStateView(
              message: state.errorMessage ?? 'Unable to load quote.',
              onRetry: () => context.read<BookingBloc>().add(
                BookingQuoteRequested(slotId),
              ),
            );
          }
          final quote = state.quote;
          if (quote == null) return const LoadingView();
          return BookingConfirmScreen(
            doctorName: quote.doctorName,
            specialty: quote.specialty,
            clinicName: quote.clinic,
            address: quote.address ?? '${quote.area}, ${quote.city}',
            day: quote.day,
            date: quote.date,
            time: quote.startTime,
            fee: quote.consultationFee.round(),
            reasonController: reasonController,
            isLoading: state.status == FeatureStatus.loading,
            onConfirm: () => context.read<BookingBloc>().add(
              BookingConfirmed(
                reason: reasonController.text.trim().isEmpty
                    ? null
                    : reasonController.text.trim(),
              ),
            ),
          );
        },
      ),
    );
  }

  static Widget _buildRescheduleConfirm(BuildContext context, Map arguments) {
    final bloc = arguments['rescheduleBloc'] as RescheduleBloc;
    final appointmentsBloc =
        arguments['appointmentsBloc'] as MyAppointmentsBloc?;
    return BlocProvider<RescheduleBloc>.value(
      value: bloc,
      child: BlocConsumer<RescheduleBloc, RescheduleState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.appointment != null) {
            appointmentsBloc?.add(const MyAppointmentsRequested());
            Navigator.popUntil(
              context,
              (route) => route.settings.name == appointmentDetail,
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final quote = state.quote;
          if (quote == null && state.status == FeatureStatus.failure) {
            return ErrorStateView(
              message: state.errorMessage ?? 'Unable to load quote.',
              onRetry: () {
                final appointmentId = state.appointmentId,
                    slotId = state.newSlotId;
                if (appointmentId != null && slotId != null) {
                  context.read<RescheduleBloc>().add(
                    RescheduleSlotChosen(appointmentId, slotId),
                  );
                }
              },
            );
          }
          if (quote == null) return const LoadingView();
          return BookingConfirmScreen(
            doctorName: quote.doctorName,
            specialty: quote.specialty,
            clinicName: quote.clinic,
            address: quote.address ?? '${quote.area}, ${quote.city}',
            day: quote.day,
            date: quote.date,
            time: quote.startTime,
            fee: quote.consultationFee.round(),
            isLoading: state.status == FeatureStatus.loading,
            onConfirm: () =>
                context.read<RescheduleBloc>().add(const RescheduleConfirmed()),
          );
        },
      ),
    );
  }

  static Widget _buildSignIn(BuildContext context) {
    final phone = TextEditingController();
    final password = TextEditingController();
    return BlocProvider(
      create: (context) => SignInBloc(
        context.read<AuthRepository>(),
        context.read<SessionBloc>(),
      ),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status == FeatureStatus.success) {
            Navigator.pushNamedAndRemoveUntil(context, mainShell, (_) => false);
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) => SignInScreen(
          phoneController: phone,
          passwordController: password,
          isLoading: state.status == FeatureStatus.loading,
          onSubmit: () => context.read<SignInBloc>().add(
            SignInSubmitted(phone.text, password.text),
          ),
          onCreateAccount: () => Navigator.pushNamed(context, signUp),
        ),
      ),
    );
  }

  static Widget _buildSignUp(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
        context.read<AuthRepository>(),
        context.read<SessionBloc>(),
      ),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.otpSent) {
            Navigator.pushNamed(
              context,
              otp,
              arguments: context.read<SignUpBloc>(),
            );
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) => SignUpScreen(
          isLoading: state.status == FeatureStatus.loading,
          onSubmit: (phone, username, date, bio, password) =>
              context.read<SignUpBloc>().add(
                SignUpDetailsSubmitted(
                  phone: phone,
                  username: username,
                  dateOfBirth: date,
                  bio: bio,
                  password: password,
                ),
              ),
        ),
      ),
    );
  }

  static Widget _buildOtp(BuildContext context) {
    final bloc = ModalRoute.of(context)?.settings.arguments as SignUpBloc?;
    if (bloc == null) {
      return const ErrorStateView(
        message: 'Registration details were not found.',
        onRetry: _emptyAction,
      );
    }
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state.patient != null) {
            Navigator.pushNamedAndRemoveUntil(context, mainShell, (_) => false);
          }
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) => OtpScreen(
          phoneNumber: state.phone ?? '',
          isLoading: state.status == FeatureStatus.loading,
          onVerify: (otp) =>
              context.read<SignUpBloc>().add(SignUpOtpSubmitted(otp)),
          onResend: () =>
              context.read<SignUpBloc>().add(const SignUpOtpResent()),
        ),
      ),
    );
  }

  static Widget _buildBookingSuccess(BuildContext context) {
    final appointment = ModalRoute.of(context)?.settings.arguments as dynamic;
    final summary = appointment == null
        ? const <String>[]
        : <String>[
            appointment.doctorName,
            '${appointment.day}, ${appointment.date}',
            appointment.startTime,
            appointment.clinic,
            '${appointment.consultationFee.round()}',
          ];
    return BookingSuccessScreen(
      summaryLines: summary,
      onViewAppointments: () => Navigator.pushNamedAndRemoveUntil(
        context,
        appointments,
        (_) => false,
      ),
      onBackHome: () =>
          Navigator.pushNamedAndRemoveUntil(context, mainShell, (_) => false),
    );
  }

  static T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }

  static List<String> _timesForPeriod(List<SlotTime> times, int period) => times
      .where((slot) {
        final match = RegExp(r'^(\d{1,2})').firstMatch(slot.time.trim());
        if (match == null) return period == 0;
        var hour = int.tryParse(match.group(1)!) ?? 0;
        final normalized = slot.time.toLowerCase();
        if (normalized.contains('pm') && hour < 12) hour += 12;
        if (normalized.contains('am') && hour == 12) hour = 0;
        return period == 0
            ? hour < 12
            : period == 1
            ? hour >= 12 && hour < 17
            : hour >= 17;
      })
      .map((slot) => slot.time)
      .toList();

  static String _initials(String name) => name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0])
      .join()
      .toUpperCase();
  static DoctorSearchFilters _sortFilter(
    String value,
    DoctorSearchFilters current,
  ) => DoctorSearchFilters(
    specialty: current.specialty,
    city: current.city,
    area: current.area,
    gender: current.gender,
    language: current.language,
    maxFee: current.maxFee,
    minRating: current.minRating,
    need: current.need,
    sortBy: value.toLowerCase().contains('fee')
        ? 'fee_low'
        : value.toLowerCase().contains('rating')
        ? 'rating'
        : null,
    limit: current.limit,
  );

  static void _emptyAction() {}

  static Widget _buildChat(BuildContext context) {
    final input = TextEditingController();
    return BlocProvider(
      create: (context) =>
          ChatBloc(context.read<ChatRepository>())..add(const ChatStarted()),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) => ChatScreen(
          messages: const [],
          messageAuthors: const [],
          suggestions: const [
            'Find a doctor near me',
            'Show available appointment times',
          ],
          sourceNames: const [],
          chatMessages: state.messages,
          showDisclaimer: state.messages.any(
            (message) => message.showDisclaimer,
          ),
          inputController: input,
          isSending: state.isStreaming,
          onSend: () {
            final text = input.text;
            input.clear();
            context.read<ChatBloc>().add(ChatMessageSent(text));
          },
          onSuggestionSelected: (text) =>
              context.read<ChatBloc>().add(ChatMessageSent(text)),
          onViewDoctorId: (doctorId) =>
              Navigator.pushNamed(context, doctorProfile, arguments: doctorId),
          onNewConversation: state.isStreaming
              ? null
              : () => context.read<ChatBloc>().add(
                  const ChatNewConversationStarted(),
                ),
          onConfirmBooking: () => context.read<ChatBloc>().add(
            const ChatMessageSent('Yes, confirm this booking'),
          ),
          onChangeTime: () => context.read<ChatBloc>().add(
            const ChatMessageSent('Show me other times for this doctor'),
          ),
        ),
      ),
    );
  }

  static Widget _buildAppointments(BuildContext context) => BlocProvider(
    create: (context) =>
        MyAppointmentsBloc(context.read<AppointmentRepository>())
          ..add(const MyAppointmentsRequested()),
    child: BlocBuilder<MyAppointmentsBloc, MyAppointmentsState>(
      builder: (context, state) {
        final appointments = state.appointments;
        return MyAppointmentsScreen(
          doctorNames: appointments.map((item) => item.doctorName).toList(),
          specialties: appointments.map((item) => item.specialty).toList(),
          days: appointments.map((item) => item.day).toList(),
          dates: appointments.map((item) => item.date).toList(),
          times: appointments.map((item) => item.startTime).toList(),
          clinics: appointments.map((item) => item.clinic).toList(),
          statuses: appointments.map((item) => item.status).toList(),
          statusColors: appointments
              .map((item) => _appointmentStatusColor(item.status))
              .toList(),
          isUpcoming: appointments.map((item) => item.isUpcoming).toList(),
          isLoading: state.status == FeatureStatus.loading,
          errorMessage: state.status == FeatureStatus.failure
              ? state.errorMessage
              : null,
          onRetry: () => context.read<MyAppointmentsBloc>().add(
            const MyAppointmentsRequested(),
          ),
          onTabChanged: (upcoming) => context.read<MyAppointmentsBloc>().add(
            MyAppointmentsTabChanged(upcoming),
          ),
          onAppointmentTap: (index) => Navigator.pushNamed(
            context,
            appointmentDetail,
            arguments: {
              'appointment': appointments[index],
              'appointmentsBloc': context.read<MyAppointmentsBloc>(),
            },
          ),
        );
      },
    ),
  );

  static Color _appointmentStatusColor(String status) {
    switch (status) {
      case 'booked':
        return AppColors.primary;
      case 'completed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.textSecondary;
      default:
        return AppColors.warning;
    }
  }

  static Widget _buildAppointmentDetail(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is! Map) {
      return const ErrorStateView(
        message: 'Appointment not found.',
        onRetry: _emptyAction,
      );
    }
    final appointment = arguments['appointment'] as Appointment?;
    if (appointment == null) {
      return const ErrorStateView(
        message: 'Appointment not found.',
        onRetry: _emptyAction,
      );
    }
    final appointmentsBloc =
        arguments['appointmentsBloc'] as MyAppointmentsBloc?;
    if (appointmentsBloc == null) {
      return const ErrorStateView(
        message: 'Appointment list is not available.',
        onRetry: _emptyAction,
      );
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<MyAppointmentsBloc>.value(value: appointmentsBloc),
        BlocProvider(
          create: (context) => RescheduleBloc(
            context.read<DoctorRepository>(),
            context.read<AppointmentRepository>(),
          ),
        ),
      ],
      child: BlocListener<MyAppointmentsBloc, MyAppointmentsState>(
        listenWhen: (previous, current) =>
            previous.status == FeatureStatus.loading &&
            current.status == FeatureStatus.success,
        listener: (context, state) => Navigator.pop(context),
        child: Builder(
          builder: (context) => AppointmentDetailScreen(
            doctor: appointment.doctorName,
            specialty: appointment.specialty,
            day: appointment.day,
            date: appointment.date,
            time: appointment.startTime,
            clinic: appointment.clinic,
            address:
                appointment.address ??
                '${appointment.area}, ${appointment.city}',
            status: appointment.status,
            statusColor: _appointmentStatusColor(appointment.status),
            isCompleted: appointment.status == 'completed',
            onCancel: () => context.read<MyAppointmentsBloc>().add(
              AppointmentCancelRequested(appointment.appointmentId),
            ),
            onReschedule: () => Navigator.pushNamed(
              context,
              slotPicker,
              arguments: {
                'doctorId': appointment.doctorId,
                'appointmentId': appointment.appointmentId,
                'rescheduleBloc': context.read<RescheduleBloc>(),
                'appointmentsBloc': appointmentsBloc,
              },
            ),
            onWriteReview: () => Navigator.pushNamed(
              context,
              writeReview,
              arguments: appointment.appointmentId,
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildWriteReview(BuildContext context) {
    final appointmentId = ModalRoute.of(context)?.settings.arguments as String?;
    if (appointmentId == null) {
      return const ErrorStateView(
        message: 'Appointment not found.',
        onRetry: _emptyAction,
      );
    }
    return BlocProvider(
      create: (context) =>
          WriteReviewBloc(context.read<AppointmentRepository>(), appointmentId),
      child: BlocConsumer<WriteReviewBloc, WriteReviewState>(
        listener: (context, state) {
          if (state.result != null) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'New rating: ${state.result!.newRating.toStringAsFixed(1)} (${state.result!.reviewCount} reviews)',
                ),
              ),
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) => WriteReviewScreen(
          rating: state.rating,
          isLoading: state.status == FeatureStatus.loading,
          onRatingChanged: (rating) =>
              context.read<WriteReviewBloc>().add(ReviewRatingChanged(rating)),
          onSubmit: (_, comment) =>
              context.read<WriteReviewBloc>().add(ReviewSubmitted(comment)),
        ),
      ),
    );
  }

  static Widget _buildWaitingList(BuildContext context) => BlocProvider(
    create: (context) =>
        WaitingListBloc(context.read<WaitingListRepository>())
          ..add(const WaitingListRequested()),
    child: BlocBuilder<WaitingListBloc, WaitingListState>(
      builder: (context, state) {
        final entries = state.entries;
        return WaitingListScreen(
          doctorNames: entries.map((entry) => entry.doctorName).toList(),
          preferredDates: entries
              .map((entry) => entry.preferredDate ?? '')
              .toList(),
          slotOffered: entries
              .map((entry) => entry.status == 'offered')
              .toList(),
          offeredTimes: entries
              .map((entry) => entry.offeredTime ?? '')
              .toList(),
          expiryTimes: entries
              .map((entry) => entry.offerExpiresAt ?? '')
              .toList(),
          waitingIds: entries.map((entry) => entry.waitingId).toList(),
          offeredSlotIds: entries
              .map((entry) => entry.offeredSlotId ?? '')
              .toList(),
          isLoading: state.status == FeatureStatus.loading,
          errorMessage: state.status == FeatureStatus.failure
              ? state.errorMessage
              : null,
          onRetry: () =>
              context.read<WaitingListBloc>().add(const WaitingListRequested()),
          onLeave: (index) => context.read<WaitingListBloc>().add(
            WaitingListLeft(entries[index].waitingId),
          ),
          onBook: (index) {
            final slotId = entries[index].offeredSlotId;
            if (slotId != null) {
              Navigator.pushNamed(context, bookingConfirm, arguments: slotId);
            }
          },
        );
      },
    ),
  );

  static Widget _buildProfile(BuildContext context) => BlocProvider(
    create: (context) => ProfileBloc(
      context.read<ProfileRepository>(),
      context.read<DoctorRepository>(),
      context.read<SessionBloc>(),
    )..add(const ProfileRequested()),
    child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == FeatureStatus.initial ||
            state.status == FeatureStatus.loading) {
          return const LoadingView();
        }
        if (state.status == FeatureStatus.failure || state.profile == null) {
          return ErrorStateView(
            message: state.errorMessage ?? 'Unable to load profile.',
            onRetry: () =>
                context.read<ProfileBloc>().add(const ProfileRequested()),
          );
        }
        final patient = state.profile!;
        return ProfileScreen(
          initials: _initials(patient.fullName),
          name: patient.fullName,
          username: patient.username ?? '',
          phone: patient.phone,
          email: patient.email ?? '',
          city: patient.city ?? '',
          gender: patient.gender ?? '',
          dateOfBirth: patient.dateOfBirth ?? '',
          bio: patient.bio ?? '',
          onEditProfile: () => Navigator.pushNamed(
            context,
            editProfile,
            arguments: context.read<ProfileBloc>(),
          ),
          onWaitingList: () => Navigator.pushNamed(context, waitingList),
          onNotifications: () {},
          onSignOut: () =>
              context.read<ProfileBloc>().add(const ProfileSignOutPressed()),
        );
      },
    ),
  );

  static Widget _buildEditProfile(BuildContext context) {
    final profileBloc =
        ModalRoute.of(context)?.settings.arguments as ProfileBloc?;
    if (profileBloc == null) {
      return const ErrorStateView(
        message: 'Profile is not available.',
        onRetry: _emptyAction,
      );
    }
    final profile = profileBloc.state.profile;
    if (profile == null) return const LoadingView();
    return BlocProvider<ProfileBloc>.value(
      value: profileBloc,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) =>
            previous.status == FeatureStatus.loading &&
                current.status == FeatureStatus.success ||
            current.status == FeatureStatus.failure,
        listener: (context, state) {
          if (state.status == FeatureStatus.success) Navigator.pop(context);
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) => EditProfileScreen(
          cityNames: state.cities.map((city) => city.name).toList(),
          fullName: profile.fullName,
          email: profile.email ?? '',
          city: profile.city ?? '',
          gender: profile.gender ?? '',
          dateOfBirth: profile.dateOfBirth ?? '',
          isLoading: state.status == FeatureStatus.loading,
          onSave: (fullName, email, city, gender, dateOfBirth) {
            if (fullName == profile.fullName &&
                email == (profile.email ?? '') &&
                city == (profile.city ?? '') &&
                gender == (profile.gender ?? '') &&
                dateOfBirth == (profile.dateOfBirth ?? '')) {
              Navigator.pop(context);
              return;
            }
            context.read<ProfileBloc>().add(
              ProfileUpdated(
                fullName: fullName,
                email: email,
                city: city,
                gender: gender,
                dateOfBirth: dateOfBirth,
              ),
            );
          },
        ),
      ),
    );
  }
}
