// Editable patient contact and personal details form.
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/common/app_text_field.dart';
import '../../../widgets/common/primary_button.dart';

/// Profile editor with caller supplied city choices and save callback.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.cityNames,
    required this.onSave,
    this.fullName = '',
    this.email = '',
    this.city = '',
    this.gender = '',
    this.dateOfBirth = '',
    this.isLoading = false,
  });
  final List<String> cityNames;
  final void Function(
    String fullName,
    String email,
    String city,
    String gender,
    String dateOfBirth,
  )
  onSave;
  final String fullName, email, city, gender, dateOfBirth;
  final bool isLoading;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

/// Owns the profile form's editable values.
class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController fullNameController = TextEditingController(
    text: widget.fullName,
  );

  late final TextEditingController emailController = TextEditingController(
    text: widget.email,
  );
  late String selectedCity = widget.city;
  late String selectedGender = widget.gender.trim().toLowerCase();
  DateTime? selectedDate;
  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(AppStrings.editProfile)),

    body: ListView(
      padding: const EdgeInsets.all(AppSpacing.extraLarge),
      children: [
        Text(AppStrings.editProfile, style: AppTextStyles.heading),
        const SizedBox(height: AppSpacing.large),
        AppTextField(
          label: AppStrings.fullName,
          hint: AppStrings.textFieldHint,
          controller: fullNameController,
        ),
        const SizedBox(height: AppSpacing.large),
        AppTextField(
          label: AppStrings.email,
          hint: AppStrings.email,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.large),
        DropdownButtonFormField<String>(
          initialValue: selectedCity.isEmpty ? null : selectedCity,
          decoration: const InputDecoration(labelText: AppStrings.city),
          items: widget.cityNames
              .map(
                (cityName) =>
                    DropdownMenuItem(value: cityName, child: Text(cityName)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => selectedCity = value);
          },
        ),
        const SizedBox(height: AppSpacing.large),
        DropdownButtonFormField<String>(
          initialValue: selectedGender.isEmpty ? null : selectedGender,
          decoration: const InputDecoration(labelText: AppStrings.gender),
          items: const [
            DropdownMenuItem(value: 'male', child: Text(AppStrings.genderMale)),
            DropdownMenuItem(
              value: 'female',
              child: Text(AppStrings.genderFemale),
            ),
            DropdownMenuItem(
              value: 'other',
              child: Text(AppStrings.genderOther),
            ),
          ],
          onChanged: (value) {
            if (value != null) setState(() => selectedGender = value);
          },
        ),
        const SizedBox(height: AppSpacing.large),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(AppStrings.dateOfBirthLabel),
          subtitle: Text(
            selectedDate == null
                ? widget.dateOfBirth
                : _formatDate(selectedDate!),
          ),

          trailing: const Icon(Icons.calendar_today_outlined),
          onTap: selectDate,
        ),
        const SizedBox(height: AppSpacing.xxLarge),
        PrimaryButton(
          label: AppStrings.saveChanges,
          onPressed: () => widget.onSave(
            fullNameController.text,
            emailController.text,
            selectedCity,
            selectedGender,
            selectedDate == null
                ? widget.dateOfBirth
                : _formatDate(selectedDate!),
          ),

          isLoading: widget.isLoading,
        ),
      ],
    ),
  );

  String _formatDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
