import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/storage_service.dart';
import '../state/locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final StorageService _storageService;

  LocaleCubit(this._storageService)
    : super(const LocaleState(locale: Locale('en', 'US')));

  Future<void> loadSavedLocale() async {
    final savedCode = await _storageService.getSavedLanguage();
    if (savedCode != null && savedCode.isNotEmpty) {
      final parts = savedCode.split('_');
      if (parts.isNotEmpty) {
        final languageCode = parts.first;

        final countryCode = parts.length > 1 ? parts[1] : '';
        emit(LocaleState(locale: Locale(languageCode, countryCode)));
      }
    }
  }

  Future<void> changeLocale({
    required String languageCode,
    String countryCode = '',
  }) async {
    final newLocale = Locale(languageCode, countryCode);
    emit(LocaleState(locale: newLocale));
    final codeToSave = countryCode.isNotEmpty
        ? '${languageCode}_$countryCode'
        : languageCode;
    await _storageService.saveLanguage(codeToSave);
  }

  Future<void> toggleLocale() async {
    final current = state.locale;
    if (current.languageCode == 'en') {
      await changeLocale(languageCode: 'ar', countryCode: 'EG');
    } else {
      await changeLocale(languageCode: 'en', countryCode: 'US');
    }
  }
}
