import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:path_provider/path_provider.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashCubit extends Cubit<SplashStatus> {
  SplashCubit() : super(SplashStatus.initial);

  void startInitialization() async {
    try {
      emit(SplashStatus.loading);

      await setupRepositories();
      setupCubits();
      final hydratedStorage = await _initHydratedStorage();
      HydratedBloc.storage = hydratedStorage;
      await Future.delayed(const Duration(seconds: 2));

      emit(SplashStatus.loaded);
    } catch (e) {
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
