import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
// ignore: library_prefixes
import 'package:new_ajalah/core/config/router.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/state/register_steps_data.dart';
import 'package:new_ajalah/features/auth/presentation/register/widgets/role_radio_buttons.dart';
import 'package:new_ajalah/shared/widgets/app_button.dart';
import 'package:new_ajalah/shared/widgets/app_custom_link.dart';
import 'package:new_ajalah/shared/widgets/app_date_field.dart';
import 'package:new_ajalah/shared/widgets/app_loading.dart';
import 'package:new_ajalah/shared/widgets/app_phone_field.dart';
import 'package:new_ajalah/shared/widgets/app_select_field.dart';
import 'package:new_ajalah/shared/widgets/app_snack_bar.dart';
import 'package:new_ajalah/shared/widgets/app_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegisterFormSeller extends StatefulWidget {
  const RegisterFormSeller({super.key});

  @override
  State<RegisterFormSeller> createState() => _RegisterFormSellerState();
}

class _RegisterFormSellerState extends State<RegisterFormSeller> {
  late FormGroup form;
  var submitted = false;

  @override
  void initState() {
    super.initState();
    form = FormGroup(
      {
        'fName': FormControl<String>(validators: [Validators.required]),
        'lName': FormControl<String>(validators: [Validators.required]),
        'email': FormControl<String>(),
        'phone': FormControl<PhoneNumber>(validators: [Validators.required]),
        'gender': FormControl<String>(),

        'city': FormControl<String>(validators: [Validators.required]),

        'birth': FormControl<String>(validators: [Validators.required]),
        'password': FormControl<String>(
          validators: [
            Validators.required,
            Validators.minLength(8),
            passwordComplexityValidator,
          ],
        ),
        'confirmPassword': FormControl<String>(
          validators: [Validators.required],
        ),
      },
      validators: [Validators.mustMatch('password', 'confirmPassword')],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    final agreed = context.select((RegisterCubit c) => c.state.stepData.agreed);
    final t = context.t;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppSnackBar.success(context, t('registeredSuccessfully'));
        }
        if (state is RegisterFailure) {
          AppSnackBar.error(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LoadingWidget()],
            ),
          );
        }
        return ReactiveForm(
          formGroup: form,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (MediaQuery.of(context).orientation ==
              //     Orientation.landscape) ...[
              //   const ResponsiveSpacer(size: SpacerSize.xLarge),

              //   const ResponsiveSpacer(size: SpacerSize.medium),
              // ],
              Text(
                t('register'),
                style: context.textStyles.styles.headlineMedium,
              ),

              const ResponsiveSpacer(size: SpacerSize.medium),

              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      config: AppFormFieldConfig(
                        name: 'fName',
                        label: t('FirstName'),
                        hintText: t('fNameHolder'),
                      ),
                      showErrors: submitted,
                    ),
                  ),
                  const ResponsiveSpacer(
                    axis: Axis.horizontal,
                    size: SpacerSize.small,
                  ),
                  Expanded(
                    child: AppTextField(
                      config: AppFormFieldConfig(
                        name: 'lName',
                        label: t('LastName'),
                        hintText: t('lNameHolder'),
                      ),
                      showErrors: submitted,
                    ),
                  ),
                ],
              ),

              RoleRadioButtons(
                selectedRole: UserRole.seller,
                onChanged: (role) => cubit.setRole(role),
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),

              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      config: AppFormFieldConfig(
                        name: 'password',
                        label: t('password'),
                        obscureText: true,
                        forceLTR: true,

                        hintText: '********',
                      ),
                      showErrors: submitted,
                    ),
                  ),
                  const ResponsiveSpacer(
                    axis: Axis.horizontal,
                    size: SpacerSize.small,
                  ),
                  Expanded(
                    child: AppTextField(
                      config: AppFormFieldConfig(
                        name: 'confirmPassword',
                        label: t('ConfirmPassword'),
                        forceLTR: true,

                        obscureText: true,
                        hintText: '********',
                      ),
                      showErrors: submitted,
                    ),
                  ),
                ],
              ),

              AppPhoneField(
                config: AppFormFieldConfig(
                  name: 'phone',
                  label: t('phone'),
                  hintText: '',
                  keyboardType: TextInputType.phone,
                ),
                showErrors: submitted,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      config: AppFormFieldConfig(
                        name: 'email',
                        label: t('email'),
                        hintText: 'Info.dot@',
                        forceLTR: true,
                      ),
                      showErrors: submitted,
                    ),
                  ),
                  const ResponsiveSpacer(
                    axis: Axis.horizontal,
                    size: SpacerSize.small,
                  ),

                  Expanded(
                    child: AppDateField(
                      config: AppFormFieldConfig(
                        name: 'birth',
                        label: t('birthDate'),
                        hintText: 'DD/MM/YYYY',
                      ),
                      showErrors: submitted,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: AppSelectField(
                      config: AppFormFieldConfig(
                        name: 'city',
                        label: t('City'),
                        hintText: t('Choose'),
                      ),
                      showErrors: submitted,
                      items: [
                        DropdownMenuItem(
                          value: 'Damascus',
                          child: Text(t('Damascus')),
                        ),
                        DropdownMenuItem(
                          value: 'Aleppo',
                          child: Text(t('Aleppo')),
                        ),
                        DropdownMenuItem(value: 'Homs', child: Text(t('Homs'))),
                        DropdownMenuItem(
                          value: 'Latakia',
                          child: Text(t('Latakia')),
                        ),
                        DropdownMenuItem(
                          value: 'Daraa',
                          child: Text(t('Daraa')),
                        ),
                        DropdownMenuItem(
                          value: 'Tartus',
                          child: Text(t('Tartus')),
                        ),
                        DropdownMenuItem(
                          value: 'Idlib',
                          child: Text(t('Idlib')),
                        ),
                        DropdownMenuItem(
                          value: 'Deirez-Zor',
                          child: Text(t('Deirez-Zor')),
                        ),
                        DropdownMenuItem(
                          value: 'Raqqa',
                          child: Text(t('Raqqa')),
                        ),
                        DropdownMenuItem(
                          value: 'Hasakah',
                          child: Text(t('Hasakah')),
                        ),
                        DropdownMenuItem(value: 'Hama', child: Text(t('Hama'))),
                        DropdownMenuItem(
                          value: 'Quneitra',
                          child: Text(t('Quneitra')),
                        ),
                        DropdownMenuItem(
                          value: 'Al-Sweida',
                          child: Text(t('Al-Sweida')),
                        ),
                        DropdownMenuItem(
                          value: 'RuralDamascus',
                          child: Text(t('RuralDamascus')),
                        ),
                      ],
                    ),
                  ),
                  const ResponsiveSpacer(
                    axis: Axis.horizontal,
                    size: SpacerSize.small,
                  ),
                  Expanded(
                    child: AppSelectField(
                      config: AppFormFieldConfig(
                        name: 'gender',
                        label: t('Gender'),
                        hintText: t('Choose'),
                      ),
                      showErrors: submitted,
                      items: [
                        DropdownMenuItem(value: 'Male', child: Text(t('Male'))),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text(t('Female')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          t('IAgree'),
                          style: context.textStyles.styles.labelMedium,
                        ),
                        const ResponsiveSpacer(
                          axis: Axis.horizontal,
                          size: SpacerSize.xSmall,
                        ),
                        CustomLinkText(
                          text: t('PrivacyPolicy'),
                          onTap: () => context.push(AppRoutes.privacy),
                          style: context.textStyles.styles.linkMedium,
                        ),
                        const ResponsiveSpacer(
                          axis: Axis.horizontal,
                          size: SpacerSize.xSmall,
                        ),
                        Text(
                          t("and"),
                          style: context.textStyles.styles.labelMedium,
                        ),
                        const ResponsiveSpacer(
                          axis: Axis.horizontal,
                          size: SpacerSize.xSmall,
                        ),
                        CustomLinkText(
                          text: t("Terms"),
                          onTap: () => context.push(AppRoutes.terms),
                          style: context.textStyles.styles.linkMedium,
                        ),
                        const ResponsiveSpacer(
                          axis: Axis.horizontal,
                          size: SpacerSize.xSmall,
                        ),
                        Text(
                          t("ofUse"),
                          style: context.textStyles.styles.labelMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 26,
                    height: 26,
                    child: Checkbox(
                      value: agreed,

                      onChanged: (value) {
                        cubit.setAgreed(value!);
                      },
                      fillColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return context.colors.primary.main;
                        }
                        return Colors.transparent;
                      }),
                      checkColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),
              CustomButton(
                text: t('CreateAccount'),
                onTap: () {
                  setState(() {
                    submitted = true;
                  });
                  // form.markAllAsTouched();
                  if (form.valid) {
                    if (agreed) {
                      final fName = form.control('fName').value;
                      final lName = form.control('lName').value;
                      final email = form.control('email').value;
                      final gender = form.control('gender').value;
                      final birth = form.control('birth').value;
                      final password = form.control('password').value;
                      final phone = form.control('phone').value.phoneNumber;
                      final city = form.control('city').value;
                      context.read<RegisterCubit>().registerSeller(
                        fName: fName,
                        lName: lName,
                        password: password,
                        phone: phone,
                        city: city,
                        email: email,
                        gender: gender,
                        birth: birth,
                      );
                    } else {
                      AppSnackBar.warning(context, t('mustAgree'));
                    }
                  } else {
                    form.markAllAsTouched();
                  }
                },
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t("alreadyHaveAccount"),
                          style: context.textStyles.styles.labelMedium,
                        ),
                        const ResponsiveSpacer(
                          axis: Axis.horizontal,
                          size: SpacerSize.xSmall,
                        ),
                        CustomLinkText(
                          text: t("login"),
                          onTap: () => context.push(AppRoutes.login),
                          style: context.textStyles.styles.linkMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
