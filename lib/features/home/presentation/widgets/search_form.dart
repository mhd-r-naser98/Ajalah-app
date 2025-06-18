import 'package:flutter/material.dart';
import 'package:new_ajalah/app/theme/extensions/theme_extensions.dart';
import 'package:new_ajalah/core/forms/app_form_field_config.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/shared/widgets/app_custom_link.dart';
import 'package:new_ajalah/shared/widgets/app_select_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final form = FormGroup({
      '1': FormControl<String>(),
      '2': FormControl<String>(),
      '3': FormControl<String>(),
      '4': FormControl<String>(),
      '5': FormControl<String>(),
      '6': FormControl<String>(),
      '7': FormControl<String>(),
    });
    return Container(
      transform: Matrix4.translationValues(0, -300, 0),
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Card(
        elevation: 3,
        color: context.colors.secondary.contrast,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.radius.md),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                'Find your special car',
                style: context.textStyles.styles.titleLarge.copyWith(
                  fontWeight: FontWeight.normal,
                  height: 1.2,
                  color: context.colors.secondary.main,
                ),
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),
              ReactiveForm(
                formGroup: form,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSelectField(
                      config: AppFormFieldConfig(
                        name: '1',
                        label: '',
                        hintText: t('Choose'),
                      ),
                      showErrors: false,
                      errors: false,
                      items: [
                        DropdownMenuItem(value: 'Male', child: Text(t('Male'))),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text(t('Female')),
                        ),
                      ],
                    ),
                    const ResponsiveSpacer(size: SpacerSize.small),
                    Row(
                      children: [
                        Expanded(
                          child: AppSelectField(
                            config: AppFormFieldConfig(
                              name: '2',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
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
                              name: '3',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const ResponsiveSpacer(size: SpacerSize.small),

                    Row(
                      children: [
                        Expanded(
                          child: AppSelectField(
                            config: AppFormFieldConfig(
                              name: '4',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
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
                              name: '5',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const ResponsiveSpacer(size: SpacerSize.small),

                    Row(
                      children: [
                        Expanded(
                          child: AppSelectField(
                            config: AppFormFieldConfig(
                              name: '6',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
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
                              name: '7',
                              label: '',
                              hintText: t('Choose'),
                            ),

                            showErrors: false,
                            errors: false,

                            items: [
                              DropdownMenuItem(
                                value: 'Male',
                                child: Text(t('Male')),
                              ),
                              DropdownMenuItem(
                                value: 'Female',
                                child: Text(t('Female')),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const ResponsiveSpacer(size: SpacerSize.medium),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C7B1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Text('Search'),
              ),
              const ResponsiveSpacer(size: SpacerSize.medium),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomLinkText(
                    text: 'Reset filters',
                    onTap: () {},
                    style: context.textStyles.styles.bodyLarge.copyWith(
                      color: context.colors.secondary.main,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  CustomLinkText(
                    text: 'Advanced filter',
                    onTap: () {},
                    style: context.textStyles.styles.bodyLarge.copyWith(
                      color: context.colors.secondary.main,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
