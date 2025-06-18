import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/forms/form_validation_messages.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/core/widgets/map_picker_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MapPickerField extends StatefulWidget {
  final AppFormFieldConfig config;
  final bool showErrors;
  const MapPickerField({
    super.key,
    required this.config,
    this.showErrors = false,
  });

  @override
  State<MapPickerField> createState() => _MapPickerFieldState();
}

class _MapPickerFieldState extends State<MapPickerField> {
  late FormControl<LatLng> control;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final form = ReactiveForm.of(context);
    if (form == null) {
      throw Exception('ReactiveForm not found in context');
    }
    final formGroup = form as FormGroup;
    control = formGroup.control(widget.config.name) as FormControl<LatLng>;
  }

  Future<void> _openMapPicker() async {
    final result = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialPosition: control.value ?? LatLng(33.5138, 36.2765),
        ),
      ),
    );

    if (result != null) {
      control.value = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<LatLng, LatLng>(
      formControlName: widget.config.name,
      builder: (field) {
        final hasError =
            widget.showErrors && field.control.invalid && field.control.touched;
        final selectedPosition = field.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.config.label,
              style: context.textStyles.styles.labelLarge,
            ),
            const ResponsiveSpacer(size: SpacerSize.small),
            GestureDetector(
              onTap: _openMapPicker,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.radius.md),
                  border: Border.all(
                    color: hasError
                        ? context.colors.error.main
                        : context.colors.grey[250]!,
                    width: 2,
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedPosition == null
                            ? "Choose from map"
                            : "تم اختيار الموقع ",
                        style: TextStyle(
                          fontSize: 14,
                          color: context.colors.grey[700]!,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: context.colors.primary.main,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: ReactiveFormConsumer(
                builder: (context, form, _) {
                  final hasError =
                      widget.showErrors &&
                      field.control.invalid &&
                      field.control.touched;
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
      },
    );
  }
}
