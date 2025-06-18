// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
// // ignore: library_prefixes
// import 'package:new_ajalah/core/config/router.dart' as AppRoutes;
// import 'package:new_ajalah/core/forms/app_form_field_config.dart';
// import 'package:new_ajalah/core/utils/phone_utils.dart';
// import 'package:new_ajalah/core/utils/responsive_spacer.dart';
// import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
// import 'package:new_ajalah/features/auth/presentation/login/logic/state/login_state.dart';

// import 'package:new_ajalah/features/auth/presentation/login/widgets/login_buttons.dart';
// import 'package:new_ajalah/features/auth/presentation/login/widgets/login_method_selector.dart';
// import 'package:new_ajalah/features/auth/presentation/login/widgets/remember_me.dart';
// import 'package:new_ajalah/features/auth/presentation/login/widgets/social_login.dart';
// import 'package:new_ajalah/shared/widgets/app_loading.dart';
// import 'package:new_ajalah/shared/widgets/app_phone_field.dart';
// import 'package:new_ajalah/shared/widgets/app_snack_bar.dart';
// import 'package:new_ajalah/shared/widgets/app_text_field.dart';
// import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';
// import 'package:reactive_forms/reactive_forms.dart';

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   State<LoginForm> createState() => _LoginFormState();
// }

// class _LoginFormState extends State<LoginForm> {
//   late final FormGroup form;
//   bool submitted = false;
//   bool _prefilled = false;

//   @override
//   void initState() {
//     super.initState();
//     form = FormGroup({
//       'email': FormControl<String>(),
//       'phone': FormControl<PhoneNumber>(),
//       'password': FormControl<String>(
//         validators: [Validators.required, Validators.minLength(6)],
//       ),
//     });
//   }

//   Future<void> _prefillFormIfNeeded(LoginState state) async {
//     if (state is LoginInitial && !_prefilled) {
//       final values = <String, Object?>{};

//       if (state.selected == UserLogin.phone && state.phone != null) {
//         final myPhone = await parsePhoneNumber(state.phone!);
//         values['phone'] = myPhone;
//       } else if (state.selected == UserLogin.email && state.email != null) {
//         values['email'] = state.email!;
//       }

//       if (state.password != null) {
//         values['password'] = state.password!;
//       }

//       if (values.isNotEmpty) {
//         form.patchValue(values);
//         setState(() {
//           _prefilled = true;
//         });
//       }
//     }
//   }

//   void _updateFieldValidators(UserLogin selected) {
//     form
//         .control('phone')
//         .setValidators(
//           selected == UserLogin.phone ? [Validators.required] : [],
//         );
//     form
//         .control('email')
//         .setValidators(
//           selected == UserLogin.email
//               ? [Validators.required, Validators.email]
//               : [],
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final t = context.t;

//     return BlocConsumer<LoginCubit, LoginState>(
//       listener: (context, state) {
//         if (state is LoginSuccess) {
//           AppSnackBar.success(context, t('loggedSuccessfully'));
//           context.go(AppRoutes.home);
//           // AppRouter.router.go();
//         }
//         if (state is LoginFailure) {
//           AppSnackBar.error(context, state.error);
//         }
//       },
//       builder: (context, state) {
//         UserLogin selected = context.watch<LoginCubit>().way;
//         if (state is LoginInitial) {
//           selected = state.selected ?? UserLogin.phone;
//         }
//         _updateFieldValidators(selected);

//         if (state is LoginLoading || state is LoginLoadingInitial) {
//           return const Center(
//             child: ResponsiveScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [LoadingWidget()],
//               ),
//             ),
//           );
//         }

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _prefillFormIfNeeded(state);
//         });

//         return ReactiveForm(
//           formGroup: form,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const ResponsiveSpacer(size: SpacerSize.xLarge),
//               Text(
//                 t('WelcomeBack'),
//                 style: context.textStyles.styles.headlineMedium,
//               ),
//               const ResponsiveSpacer(size: SpacerSize.large),
//               LoginMethodSelector(
//                 selected: selected,
//                 onChanged: (newWay) =>
//                     context.read<LoginCubit>().setWay(newWay),
//               ),
//               const ResponsiveSpacer(size: SpacerSize.medium),
//               if (selected == UserLogin.phone)
//                 AppPhoneField(
//                   config: AppFormFieldConfig(
//                     name: 'phone',
//                     label: '${t('phone')}*',
//                     keyboardType: TextInputType.phone,
//                   ),
//                   showErrors: true,
//                 )
//               else
//                 AppTextField(
//                   config: AppFormFieldConfig(
//                     name: 'email',
//                     label: '${t('email')}*',
//                     hintText: 'Info.dot@',
//                   ),
//                   showErrors: submitted,
//                 ),
//               const ResponsiveSpacer(size: SpacerSize.xSmall),
//               AppTextField(
//                 config: AppFormFieldConfig(
//                   name: 'password',
//                   label: '${t('password')}*',
//                   obscureText: true,
//                   hintText: '************',
//                 ),
//                 showErrors: true,
//               ),
//               const ResponsiveSpacer(size: SpacerSize.small),
//               RememberMeCheckbox(),
//               const ResponsiveSpacer(size: SpacerSize.large),
//               LoginButtons(
//                 form: form,
//                 submitted: submitted,
//                 selected: selected,
//               ),
//               const ResponsiveSpacer(size: SpacerSize.large),
//               Row(
//                 children: [
//                   Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       t('or'),
//                       style: context.textStyles.styles.labelMedium,
//                     ),
//                   ),
//                   Expanded(child: Divider(thickness: 1, color: Colors.grey)),
//                 ],
//               ),
//               const ResponsiveSpacer(size: SpacerSize.large),
//               SocialLoginButtons(),
//               const ResponsiveSpacer(size: SpacerSize.large),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/config/router.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/utils/phone_utils.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/state/login_state.dart';

import 'package:new_ajalah/features/auth/presentation/login/widgets/login_buttons.dart';
import 'package:new_ajalah/features/auth/presentation/login/widgets/login_method_selector.dart';
import 'package:new_ajalah/features/auth/presentation/login/widgets/remember_me.dart';
import 'package:new_ajalah/features/auth/presentation/login/widgets/social_login.dart';
import 'package:new_ajalah/shared/widgets/app_loading.dart';
import 'package:new_ajalah/shared/widgets/app_phone_field.dart';
import 'package:new_ajalah/shared/widgets/app_snack_bar.dart';
import 'package:new_ajalah/shared/widgets/app_text_field.dart';
import 'package:new_ajalah/shared/widgets/responsive_scroll_view.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final FormGroup form;
  bool submitted = false;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    form = FormGroup({
      'email': FormControl<String>(),
      'phone': FormControl<PhoneNumber>(),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(6)],
      ),
    });
  }

  Future<void> _prefillFormIfNeeded(LoginState state) async {
    if (state is LoginInitial && !_prefilled) {
      final values = <String, Object?>{};

      if (state.selected == UserLogin.phone && state.phone != null) {
        final myPhone = await parsePhoneNumber(state.phone!);
        values['phone'] = myPhone;
      } else if (state.selected == UserLogin.email && state.email != null) {
        values['email'] = state.email!;
      }

      if (state.password != null) {
        values['password'] = state.password!;
      }

      if (values.isNotEmpty) {
        form.patchValue(values);
        setState(() {
          _prefilled = true;
        });
      }
    }
  }

  void _updateFieldValidators(UserLogin selected) {
    form
        .control('phone')
        .setValidators(
          selected == UserLogin.phone ? [Validators.required] : [],
        );
    form
        .control('email')
        .setValidators(
          selected == UserLogin.email
              ? [Validators.required, Validators.email]
              : [],
        );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is LoginSuccess) {
          AppSnackBar.success(context, t('loggedSuccessfully'));
          context.go(AppRoutes.home);
        }
        if (state is LoginFailure) {
          AppSnackBar.error(context, state.error);
        }
      },
      buildWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType ||
            (current is LoginInitial && previous != current);
      },
      builder: (context, state) {
        UserLogin selected = context.watch<LoginCubit>().way;
        if (state is LoginInitial) {
          selected = state.selected ?? UserLogin.phone;
        }
        _updateFieldValidators(selected);

        if (state is LoginLoading) {
          return const Center(
            child: ResponsiveScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [LoadingWidget()],
              ),
            ),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _prefillFormIfNeeded(state);
        });

        return ReactiveForm(
          formGroup: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ResponsiveSpacer(size: SpacerSize.xLarge),
              Text(
                t('WelcomeBack'),
                style: context.textStyles.styles.headlineMedium,
              ),
              const ResponsiveSpacer(size: SpacerSize.large),
              LoginMethodSelector(
                selected: selected,
                onChanged: (newWay) =>
                    context.read<LoginCubit>().setWay(newWay),
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),
              if (selected == UserLogin.phone)
                AppPhoneField(
                  config: AppFormFieldConfig(
                    name: 'phone',
                    label: '${t('phone')}*',

                    keyboardType: TextInputType.phone,
                  ),
                  showErrors: true,
                )
              else
                AppTextField(
                  config: AppFormFieldConfig(
                    name: 'email',
                    label: '${t('email')}*',
                    forceLTR: true,
                    hintText: 'Info.dot@',
                  ),
                  showErrors: submitted,
                ),
              const ResponsiveSpacer(size: SpacerSize.xSmall),
              AppTextField(
                config: AppFormFieldConfig(
                  name: 'password',
                  label: '${t('password')}*',
                  forceLTR: true,

                  obscureText: true,
                  hintText: '************',
                ),
                showErrors: true,
              ),
              const ResponsiveSpacer(size: SpacerSize.small),
              RememberMeCheckbox(),
              const ResponsiveSpacer(size: SpacerSize.large),
              LoginButtons(
                form: form,
                submitted: submitted,
                selected: selected,
              ),
              const ResponsiveSpacer(size: SpacerSize.large),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      t('or'),
                      style: context.textStyles.styles.labelMedium,
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                ],
              ),
              const ResponsiveSpacer(size: SpacerSize.large),
              SocialLoginButtons(),
              const ResponsiveSpacer(size: SpacerSize.large),
            ],
          ),
        );
      },
    );
  }
}
