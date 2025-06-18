// import 'package:flutter/material.dart';
// import 'package:new_ajalah/core/forms/app_form_field_config.dart';
// import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
// import 'package:new_ajalah/core/forms/form_validation_messages.dart';
// import 'package:new_ajalah/core/utils/responsive_spacer.dart';
// import 'package:reactive_forms/reactive_forms.dart';

// class AppTextField extends StatefulWidget {
//   final AppFormFieldConfig config;
//   final bool showErrors;

//   const AppTextField({
//     super.key,
//     required this.config,
//     this.showErrors = false,
//   });

//   @override
//   State<AppTextField> createState() => _AppTextFieldState();
// }

// class _AppTextFieldState extends State<AppTextField> {
//   late bool _obscure;

//   @override
//   void initState() {
//     super.initState();
//     _obscure = widget.config.obscureText;
//   }

//   void _toggleObscure() {
//     setState(() {
//       _obscure = !_obscure;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final config = widget.config;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(config.label, style: context.textStyles.styles.labelLarge),
//         const ResponsiveSpacer(size: SpacerSize.small),
//         ReactiveFormConsumer(
//           builder: (context, form, _) {
//             final control = form.control(config.name);
//             final hasError =
//                 widget.showErrors && control.invalid && control.touched;

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ReactiveTextField<String>(
//                   style: TextStyle(fontSize: 14, color: context.colors.text),
//                   formControlName: config.name,
//                   obscureText: _obscure,
//                   keyboardType: config.keyboardType,
//                   maxLines: config.maxLines,
//                   showErrors: (_) => false,
//                   onChanged: (control) {
//                     config.onChanged?.call(control.value);
//                   },
//                   decoration: InputDecoration(
//                     hintText: config.hintText,
//                     hintStyle: TextStyle(
//                       fontSize: 14,
//                       color: context.colors.grey[700]!,
//                     ),
//                     filled: true,
//                     fillColor: Colors.transparent,
//                     isDense: true,
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 14.5,
//                       horizontal: 16,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(context.radius.md),
//                       borderSide: BorderSide(
//                         color: hasError
//                             ? context.colors.error.main
//                             : context.colors.grey[250]!,
//                         width: 2.0,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(context.radius.md),
//                       borderSide: BorderSide(
//                         color: hasError
//                             ? context.colors.error.main
//                             : context.colors.grey[250]!,
//                         width: 2.0,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(context.radius.md),
//                       borderSide: BorderSide(
//                         color: hasError
//                             ? context.colors.error.main
//                             : context.colors.primary.main,
//                         width: 2.0,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(context.radius.md),
//                       borderSide: BorderSide(
//                         color: hasError
//                             ? context.colors.error.main
//                             : context.colors.grey[250]!,
//                         width: 2.0,
//                       ),
//                     ),
//                     suffixIcon: config.obscureText
//                         ? IconButton(
//                             onPressed: _toggleObscure,
//                             icon: Icon(
//                               _obscure
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                               color: context.colors.grey[700],
//                             ),
//                           )
//                         : null,
//                   ),
//                 ),
//                 Container(
//                   height: 20,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.only(top: 4, left: 8),
//                   child: Text(
//                     hasError ? getErrorMessage(context, control) : "",
//                     style: TextStyle(
//                       color: context.colors.error.main,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppTextField extends StatefulWidget {
  final AppFormFieldConfig config;
  final bool showErrors;

  const AppTextField({
    super.key,
    required this.config,
    this.showErrors = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.config.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = widget.config;

    final bool forceLTR =
        config.forceLTR ??
        config.obscureText || config.keyboardType == TextInputType.emailAddress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(config.label, style: context.textStyles.styles.labelLarge),
        const ResponsiveSpacer(size: SpacerSize.small),
        Directionality(
          textDirection: forceLTR
              ? TextDirection.ltr
              : Directionality.of(context),
          child: ReactiveFormConsumer(
            builder: (context, form, _) {
              final control = form.control(config.name);
              final hasError =
                  widget.showErrors && control.invalid && control.touched;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReactiveTextField<String>(
                    style: TextStyle(fontSize: 14, color: context.colors.text),
                    formControlName: config.name,
                    obscureText: _obscure,
                    keyboardType: config.keyboardType,
                    maxLines: config.maxLines,
                    showErrors: (_) => false,
                    onChanged: (control) {
                      config.onChanged?.call(control.value);
                    },
                    decoration: InputDecoration(
                      hintText: config.hintText,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: context.colors.grey[700]!,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14.5,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.md),
                        borderSide: BorderSide(
                          color: hasError
                              ? context.colors.error.main
                              : context.colors.grey[250]!,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.md),
                        borderSide: BorderSide(
                          color: hasError
                              ? context.colors.error.main
                              : context.colors.grey[250]!,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.md),
                        borderSide: BorderSide(
                          color: hasError
                              ? context.colors.error.main
                              : context.colors.primary.main,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(context.radius.md),
                        borderSide: BorderSide(
                          color: context.colors.error.main,
                          width: 2.0,
                        ),
                      ),
                      suffixIcon: config.obscureText
                          ? IconButton(
                              onPressed: _toggleObscure,
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: context.colors.grey[700],
                              ),
                            )
                          : null,
                    ),
                  ),
                  Container(
                    height: 20,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      hasError ? getErrorMessage(context, control) : "",
                      style: TextStyle(
                        color: context.colors.error.main,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
