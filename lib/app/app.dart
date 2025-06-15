import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new_ajalah/app/localization/app_localizations.dart';
import 'package:new_ajalah/app/theme/logic/cubit/theme_cubit.dart';
import 'package:new_ajalah/core/utils/size_config.dart';
import 'router.dart';
import 'localization/logic/cubit/locale_cubit.dart';
import 'theme/app_theme.dart';
import '../core/services/storage_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = GetIt.instance<StorageService>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(storageService)..loadSavedLocale(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(storageService)..loadSavedTheme(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final locale = context.select(
            (LocaleCubit bloc) => bloc.state.locale,
          );
          final isDarkMode = context.select(
            (ThemeCubit bloc) => bloc.state.isDarkMode,
          );
          SizeConfig().init(context);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
