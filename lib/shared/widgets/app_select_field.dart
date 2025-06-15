import 'package:flutter/material.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppSelectField<T> extends StatelessWidget {
  final AppFormFieldConfig config;
  final List<DropdownMenuItem<T>> items;
  final bool showErrors;

  const AppSelectField({
    super.key,
    required this.config,
    required this.items,
    this.showErrors = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.label, style: context.textStyles.styles.labelLarge),
        const ResponsiveSpacer(size: SpacerSize.small),
        ReactiveFormConsumer(
          builder: (context, form, _) {
            final control = form.control(config.name);
            final hasError = showErrors && control.invalid && control.touched;

            return ReactiveDropdownField<T>(
              showErrors: (_) => false,
              formControlName: config.name,
              style: TextStyle(fontSize: 14, color: context.colors.text),
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
                  vertical: 12,
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
                    color: hasError
                        ? context.colors.error.main
                        : context.colors.primary.main,
                    width: 2.0,
                  ),
                ),
              ),
              items: items,
            );
          },
        ),
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: 4, left: 8),
          child: ReactiveFormConsumer(
            builder: (context, form, _) {
              final control = form.control(config.name);
              final hasError = showErrors && control.invalid && control.touched;
              return Text(
                hasError ? getErrorMessage(context, control) : '',
                style: TextStyle(
                  color: context.colors.error.main,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
        ),
      ],
    );
  }
}
