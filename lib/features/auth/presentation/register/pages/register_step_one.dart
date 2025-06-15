// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:new_ajalah/app/localization/app_localizations.dart';
// import 'package:new_ajalah/app/router.dart';
// import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
// import 'package:new_ajalah/core/config/router.dart' as AppRoutes;
// import 'package:new_ajalah/core/forms/app_form_field_config.dart';
// import 'package:new_ajalah/core/utils/responsive_spacer.dart';
// import 'package:new_ajalah/features/auth/logic/state/register_steps_data.dart';
// import 'package:new_ajalah/features/auth/presentation/widgets/role_radio_buttons.dart';
// import 'package:new_ajalah/shared/widgets/app_button.dart';
// import 'package:new_ajalah/shared/widgets/app_custom_link.dart';
// import 'package:new_ajalah/shared/widgets/app_date_field.dart';
// import 'package:new_ajalah/shared/widgets/app_loading.dart';
// import 'package:new_ajalah/shared/widgets/app_map.dart';
// import 'package:new_ajalah/shared/widgets/app_phone_field.dart';
// import 'package:new_ajalah/shared/widgets/app_select_field.dart';
// import 'package:new_ajalah/shared/widgets/app_snack_bar.dart';
// import 'package:new_ajalah/shared/widgets/app_text_field.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import '../../../logic/cubit/register_cubit.dart';

// class RegisterStepOne extends StatefulWidget {
//   const RegisterStepOne({super.key});
//   @override
//   State<RegisterStepOne> createState() => _RegisterStepOne();
// }

// class _RegisterStepOne extends State<RegisterStepOne> {
//   late FormGroup form;
//   var submitted = false;
//   UserRole? currentRole;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final role = context.read<RegisterCubit>().state.stepData.role;

//     if (role != currentRole) {
//       currentRole = role;
//       final isDealer = role == UserRole.dealer;

//       form = FormGroup(
//         {
//           'fName': FormControl<String>(
//             validators: isDealer ? [] : [Validators.required],
//           ),
//           'lName': FormControl<String>(
//             validators: isDealer ? [] : [Validators.required],
//           ),
//           'email': FormControl<String>(),
//           'website': FormControl<String>(),
//           'phone': FormControl<PhoneNumber>(validators: [Validators.required]),
//           'gender': FormControl<String>(),
//           'location': FormControl<LatLng>(
//             value: null,
//             validators: [Validators.required],
//           ),
//           'city': FormControl<String>(validators: [Validators.required]),
//           'tradingName': FormControl<String>(
//             validators: isDealer ? [Validators.required] : [],
//           ),
//           'description': FormControl<String>(),
//           'birth': FormControl<String>(
//             validators: isDealer ? [] : [Validators.required],
//           ),
//           'password': FormControl<String>(
//             validators: [Validators.required, Validators.minLength(6)],
//           ),
//           'confirmPassword': FormControl<String>(
//             validators: [Validators.required],
//           ),
//         },
//         validators: [Validators.mustMatch('password', 'confirmPassword')],
//       );

//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<RegisterCubit>();
//     final role = context.select((RegisterCubit c) => c.state.stepData.role);
//     final agreed = context.select((RegisterCubit c) => c.state.stepData.agreed);
//     final t = AppLocalizations.of(context)!;

//     return BlocConsumer<RegisterCubit, RegisterState>(
//       listener: (context, state) {
//         if (state is RegisterSuccess) {
//           AppSnackBar.success(context, 'تم الحفظ بنجاح');
//         }
//         if (state is RegisterFailure) {
//           AppSnackBar.error(context, 'خطأ');
//         }
//       },
//       builder: (context, state) {
//         if (state is RegisterLoading) {
//           return const Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [LoadingWidget()],
//             ),
//           );
//         }
//         return ReactiveForm(
//           formGroup: form,

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (MediaQuery.of(context).orientation ==
//                   Orientation.landscape) ...[
//                 const ResponsiveSpacer(size: SpacerSize.xLarge),

//                 const ResponsiveSpacer(size: SpacerSize.medium),
//               ],
//               Text(
//                 t.ts('register'),
//                 style: context.textStyles.styles.headlineMedium,
//               ),

//               const ResponsiveSpacer(size: SpacerSize.medium),
//               if (role == UserRole.dealer) ...[
//                 Row(
//                   children: [
//                     Expanded(
//                       child: AppTextField(
//                         config: const AppFormFieldConfig(
//                           name: 'tradingName',
//                           label: 'Trading Name*',
//                           hintText: 'Car agency',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                     const ResponsiveSpacer(
//                       axis: Axis.horizontal,
//                       size: SpacerSize.small,
//                     ),
//                     Expanded(
//                       child: AppPhoneField(
//                         config: const AppFormFieldConfig(
//                           name: 'phone',
//                           label: 'Phone*',
//                           hintText: '',
//                           keyboardType: TextInputType.phone,
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],

//               if (role == UserRole.seller) ...[
//                 Row(
//                   children: [
//                     Expanded(
//                       child: AppTextField(
//                         config: const AppFormFieldConfig(
//                           name: 'fName',
//                           label: 'First Name',
//                           hintText: 'John.g.e',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                     const ResponsiveSpacer(
//                       axis: Axis.horizontal,
//                       size: SpacerSize.small,
//                     ),
//                     Expanded(
//                       child: AppTextField(
//                         config: const AppFormFieldConfig(
//                           name: 'lName',
//                           label: 'Last Name',
//                           hintText: 'Deo',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],

//               RoleRadioButtons(
//                 selectedRole: role,
//                 onChanged: (newRole) => cubit.setRole(newRole),
//               ),
//               const ResponsiveSpacer(size: SpacerSize.medium),

//               Row(
//                 children: [
//                   Expanded(
//                     child: AppTextField(
//                       config: const AppFormFieldConfig(
//                         name: 'password',
//                         label: 'Password',
//                         obscureText: true,
//                         hintText: 'Enter password',
//                       ),
//                       showErrors: submitted,
//                     ),
//                   ),
//                   const ResponsiveSpacer(
//                     axis: Axis.horizontal,
//                     size: SpacerSize.small,
//                   ),
//                   Expanded(
//                     child: AppTextField(
//                       config: const AppFormFieldConfig(
//                         name: 'confirmPassword',
//                         label: 'Confirm Password',
//                         obscureText: true,
//                         hintText: 'Enter Confirm Password',
//                       ),
//                       showErrors: submitted,
//                     ),
//                   ),
//                 ],
//               ),
//               if (role == UserRole.dealer)
//                 AppTextField(
//                   config: const AppFormFieldConfig(
//                     name: 'description',
//                     label: 'Description',
//                     maxLines: 2,
//                     hintText: 'An agency specialized in ..*',
//                   ),
//                   showErrors: submitted,
//                 ),

//               if (role == UserRole.seller)
//                 AppPhoneField(
//                   config: const AppFormFieldConfig(
//                     name: 'phone',
//                     label: 'Phone*',
//                     hintText: '',
//                     keyboardType: TextInputType.phone,
//                   ),
//                   showErrors: submitted,
//                 ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: AppTextField(
//                       config: const AppFormFieldConfig(
//                         name: 'email',
//                         label: 'Email',
//                         hintText: 'Info.dot@',
//                       ),
//                       showErrors: submitted,
//                     ),
//                   ),
//                   const ResponsiveSpacer(
//                     axis: Axis.horizontal,
//                     size: SpacerSize.small,
//                   ),
//                   if (role == UserRole.dealer) ...[
//                     Expanded(
//                       child: AppTextField(
//                         config: const AppFormFieldConfig(
//                           name: 'website',
//                           label: 'Website*',
//                           hintText: 'agency@info.co',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                   ] else
//                     Expanded(
//                       child: AppDateField(
//                         config: const AppFormFieldConfig(
//                           name: 'birth',
//                           label: 'birth Date*',
//                           hintText: 'DD/MM/YYYY',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                 ],
//               ),

//               Row(
//                 children: [
//                   Expanded(
//                     child: AppSelectField(
//                       config: const AppFormFieldConfig(
//                         name: 'city',
//                         label: 'City*',
//                         hintText: 'Choose',
//                       ),
//                       showErrors: submitted,
//                       items: [
//                         DropdownMenuItem(
//                           value: 'Damascus',
//                           child: Text('Damascus'),
//                         ),
//                         DropdownMenuItem(
//                           value: 'Aleppo',
//                           child: Text('Aleppo'),
//                         ),
//                         DropdownMenuItem(value: 'Homs', child: Text('Homs')),
//                         DropdownMenuItem(
//                           value: 'Latakia',
//                           child: Text('Latakia'),
//                         ),
//                         DropdownMenuItem(value: 'Daraa', child: Text('Daraa')),
//                         DropdownMenuItem(
//                           value: 'Tartus',
//                           child: Text('Tartus'),
//                         ),
//                         DropdownMenuItem(value: 'Idlib', child: Text('Idlib')),
//                         DropdownMenuItem(
//                           value: 'Deirez-Zor',
//                           child: Text('Deirez-Zor'),
//                         ),
//                         DropdownMenuItem(value: 'Raqqa', child: Text('Raqqa')),
//                         DropdownMenuItem(
//                           value: 'Hasakah',
//                           child: Text('Hasakah'),
//                         ),
//                         DropdownMenuItem(value: 'Hama', child: Text('Hama')),
//                         DropdownMenuItem(
//                           value: 'Quneitra',
//                           child: Text('Quneitra'),
//                         ),
//                         DropdownMenuItem(
//                           value: 'Al-Sweida',
//                           child: Text('Al-Sweida'),
//                         ),
//                         DropdownMenuItem(
//                           value: 'RuralDamascus',
//                           child: Text('RuralDamascus'),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const ResponsiveSpacer(
//                     axis: Axis.horizontal,
//                     size: SpacerSize.small,
//                   ),
//                   if (role == UserRole.seller) ...[
//                     Expanded(
//                       child: AppSelectField(
//                         config: const AppFormFieldConfig(
//                           name: 'gender',
//                           label: 'Gender',
//                           hintText: 'Choose',
//                         ),
//                         showErrors: submitted,
//                         items: [
//                           DropdownMenuItem(value: 'Male', child: Text('Male')),
//                           DropdownMenuItem(
//                             value: 'Female',
//                             child: Text('Female'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ] else
//                     Expanded(
//                       child: MapPickerField(
//                         config: const AppFormFieldConfig(
//                           name: 'location',
//                           label: 'location',
//                           hintText: '',
//                         ),
//                         showErrors: submitted,
//                       ),
//                     ),
//                 ],
//               ),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "I agree to Ajaleh’s",
//                           style: context.textStyles.styles.labelMedium,
//                         ),
//                         const ResponsiveSpacer(
//                           axis: Axis.horizontal,
//                           size: SpacerSize.xSmall,
//                         ),
//                         CustomLinkText(
//                           text: "Privacy Policy",
//                           onTap: () => AppRouter.router.go(AppRoutes.privacy),
//                           style: context.textStyles.styles.linkMedium,
//                         ),
//                         const ResponsiveSpacer(
//                           axis: Axis.horizontal,
//                           size: SpacerSize.xSmall,
//                         ),
//                         Text(
//                           "and",
//                           style: context.textStyles.styles.labelMedium,
//                         ),
//                         const ResponsiveSpacer(
//                           axis: Axis.horizontal,
//                           size: SpacerSize.xSmall,
//                         ),
//                         CustomLinkText(
//                           text: "Terms",
//                           onTap: () => AppRouter.router.go(AppRoutes.terms),
//                           style: context.textStyles.styles.linkMedium,
//                         ),
//                         const ResponsiveSpacer(
//                           axis: Axis.horizontal,
//                           size: SpacerSize.xSmall,
//                         ),
//                         Text(
//                           "of Use",
//                           style: context.textStyles.styles.labelMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 26,
//                     height: 26,
//                     child: Checkbox(
//                       value: agreed,

//                       onChanged: (value) {
//                         cubit.setAgreed(value!);
//                       },
//                       fillColor: WidgetStateProperty.resolveWith<Color>((
//                         Set<WidgetState> states,
//                       ) {
//                         if (states.contains(WidgetState.selected)) {
//                           return context.colors.primary.main;
//                         }
//                         return Colors.transparent;
//                       }),
//                       checkColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const ResponsiveSpacer(size: SpacerSize.medium),
//               CustomButton(
//                 text: 'Create Account',
//                 onTap: () {
//                   // setState(() {
//                   //   submitted = true;
//                   // });
//                   form.markAllAsTouched();
//                   print('Controls: ${form.controls.keys}');
//                   final data = form.value;
//                   debugPrint('--- Form Values ---');
//                   data.forEach((key, value) {
//                     debugPrint('$key: $value');
//                   });
//                   if (form.valid) {
//                     // context.read<LoginCubit>().logIn(
//                     //   phone: phone,
//                     //   password: pass,
//                     // );
//                   } else {
//                     form.markAllAsTouched();
//                   }
//                 },
//               ),
//               const ResponsiveSpacer(size: SpacerSize.medium),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Already have an account?",
//                           style: context.textStyles.styles.labelMedium,
//                         ),
//                         const ResponsiveSpacer(
//                           axis: Axis.horizontal,
//                           size: SpacerSize.xSmall,
//                         ),
//                         CustomLinkText(
//                           text: "Login",
//                           onTap: () => AppRouter.router.go(AppRoutes.login),
//                           style: context.textStyles.styles.linkMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/state/register_steps_data.dart';
import 'package:new_ajalah/features/auth/presentation/register/widgets/register_form_dealer.dart';
import 'package:new_ajalah/features/auth/presentation/register/widgets/register_form_seller.dart';

class RegisterStepOne extends StatelessWidget {
  const RegisterStepOne({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.select((RegisterCubit c) => c.state.stepData.role);
    switch (role) {
      case UserRole.seller:
        return RegisterFormSeller();
      case UserRole.dealer:
        return RegisterFormDealer();
      default:
        return RegisterFormSeller();
    }
  }
}
