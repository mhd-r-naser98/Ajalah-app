import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/storage_service.dart';
import '../state/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final StorageService _storageService;

  ThemeCubit(this._storageService) : super(const ThemeState(isDarkMode: false));

  Future<void> loadSavedTheme() async {
    final saved = await _storageService.getSavedThemeMode();
    if (saved != null) {
      emit(ThemeState(isDarkMode: saved));
    } else {
      emit(const ThemeState(isDarkMode: false));
    }
  }

  Future<void> toggleTheme() async {
    final newMode = !state.isDarkMode;
    emit(ThemeState(isDarkMode: newMode));
    await _storageService.saveThemeMode(newMode);
  }

  Future<void> setTheme({required bool isDark}) async {
    emit(ThemeState(isDarkMode: isDark));
    await _storageService.saveThemeMode(isDark);
  }
}
