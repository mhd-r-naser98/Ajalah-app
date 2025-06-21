// ignore_for_file: avoid_print

import 'package:ajalah/core/di/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashCubit extends Cubit<SplashStatus> {
  SplashCubit() : super(SplashStatus.initial);

  Future<void> startInitialization() async {
    try {
      emit(SplashStatus.loading);

      final hydratedStorage = await _initHydratedStorage();
      HydratedBloc.storage = hydratedStorage;

      await setupRepositories();
      setupCubits();

      await Future.delayed(const Duration(seconds: 2));

      emit(SplashStatus.loaded);
    } catch (e, stack) {
      print('SplashCubit initialization error: $e');
      print(stack);
      emit(SplashStatus.error);
    }
  }

  Future<HydratedStorage> _initHydratedStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    return HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(dir.path),
    );
  }
}
