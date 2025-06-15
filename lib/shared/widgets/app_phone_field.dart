import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AppPhoneField extends StatefulWidget {
  final AppFormFieldConfig config;
  final bool showErrors;

  const AppPhoneField({
    super.key,
    required this.config,
    this.showErrors = false,
  });

  @override
  State<AppPhoneField> createState() => _AppPhoneFieldState();
}

class _AppPhoneFieldState extends State<AppPhoneField> {
  final String _initialIsoCode = 'SY';

  @override
  Widget build(BuildContext context) {
    final config = widget.config;
    final t = context.t;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(config.label, style: context.textStyles.styles.labelLarge),
        const ResponsiveSpacer(size: SpacerSize.small),
        ReactiveFormConsumer(
          builder: (context, form, _) {
            final control =
                form.control(config.name) as FormControl<PhoneNumber>;
            final hasError =
                widget.showErrors && control.invalid && control.touched;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReactiveValueListenableBuilder<PhoneNumber>(
                  formControlName: config.name,

                  builder: (context, valueControl, child) {
                    return InternationalPhoneNumberInput(
                      initialValue:
                          valueControl.value ??
                          PhoneNumber(isoCode: _initialIsoCode),
                      selectorTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: context.colors.text,
                      ),
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: context.colors.text,
                      ),

                      searchBoxDecoration: InputDecoration(
                        hintText: t("Choose"),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: context.colors.grey[700]!,
                        ),

                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: context.colors.grey[250]!,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: context.colors.grey[250]!,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: context.colors.primary.main,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      onInputChanged: (PhoneNumber number) {
                        valueControl.updateValue(number);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        leadingPadding: 6,
                        trailingSpace: false,
                        useEmoji: true,
                        setSelectorButtonAsPrefixIcon: true,
                      ),
                      formatInput: true,
                      inputDecoration: InputDecoration(
                        hintText: config.hintText,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: context.colors.grey[700]!,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: hasError
                                ? context.colors.error.main
                                : context.colors.grey[250]!,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: hasError
                                ? context.colors.error.main
                                : context.colors.grey[250]!,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            context.radius.md,
                          ),
                          borderSide: BorderSide(
                            color: hasError
                                ? context.colors.error.main
                                : context.colors.primary.main,
                            width: 2.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      hasError ? getErrorMessage(context, control) : '',
                      style: TextStyle(
                        color: context.colors.error.main,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
