import 'package:flutter/material.dart';
import '../../app/theme/extensions/theme_extensions.dart';
import '../../core/forms/app_form_field_config.dart';
import '../../core/forms/form_validation_messages.dart';
import '../../core/utils/format_date.dart';
import '../../core/utils/responsive_spacer.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AppDateField extends StatelessWidget {
  final AppFormFieldConfig config;
  final bool showErrors;

  const AppDateField({
    super.key,
    required this.config,
    this.showErrors = false,
  });

  Future<void> _pickDate(BuildContext context, AbstractControl control) async {
    final t = context.t;
    final locale = Localizations.localeOf(context);
    final now = DateTime.now();
    final firstDate = DateTime(1900);
    final lastDate = DateTime(now.year - 15, now.month, now.day);

    final initialDate =
        DateTime.tryParse(control.value ?? '') ??
        DateTime(now.year - 20, now.month, now.day);

    final picked = await showDatePicker(
      context: context,

      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: initialDate,
      locale: locale,
      builder: (context, child) {
        final now = DateTime.now();
        final firstDate = DateTime(1900);
        final lastDate = DateTime(now.year - 15, now.month, now.day);
        final defaultDate = DateTime(now.year - 20, now.month, now.day);
        DateTime tempSelectedDate;

        if (control.value != null) {
          final parsedDate = DateTime.tryParse(control.value);
          if (parsedDate != null) {
            tempSelectedDate = parsedDate;
          } else {
            tempSelectedDate = defaultDate;
          }
        } else {
          tempSelectedDate = defaultDate;
        }
        if (tempSelectedDate.isAfter(lastDate)) {
          tempSelectedDate = lastDate;
        } else if (tempSelectedDate.isBefore(firstDate)) {
          tempSelectedDate = firstDate;
        }
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.radius.md),
              ),
              insetPadding: const EdgeInsets.all(16),
              elevation: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: context.colors.primary.main,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(context.radius.md),
                        topRight: Radius.circular(context.radius.md),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        t('ChooseDate'),

                        style: TextStyle(
                          fontSize: 20,
                          color: context.colors.secondary.contrast,
                        ),
                      ),
                    ),
                  ),
                  CalendarDatePicker(
                    initialDate: tempSelectedDate,
                    firstDate: firstDate,
                    lastDate: lastDate,
                    onDateChanged: (date) {
                      setState(() {
                        tempSelectedDate = date;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(t('Cancel')),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, tempSelectedDate);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.colors.primary.main,
                            foregroundColor: context.colors.secondary.contrast,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.radius.md,
                              ),
                            ),
                          ),
                          child: Text(t('Confirm')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (picked != null) {
      final formattedDate = picked.toIso8601String().split('T').first;
      control.updateValue(formattedDate);
    }
  }

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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _pickDate(context, control),

                  borderRadius: BorderRadius.circular(context.radius.md),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: config.hintText,
                      filled: true,
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
                    ),
                    child: Text(
                      control.value != null
                          ? formatDate(control.value)
                          : config.hintText ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: control.value != null
                            ? context.colors.text
                            : context.colors.grey[700],
                      ),
                    ),
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
      ],
    );
  }
}
