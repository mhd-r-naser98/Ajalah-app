import 'package:get_it/get_it.dart';
import 'package:new_ajalah/core/network/api_provider.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import 'package:new_ajalah/features/auth/data/auth_repo.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';

final locator = GetIt.instance;

Future<void> setupCoreServices(SecureStorageService storageService) async {
  locator.registerSingleton<StorageService>(storageService);
  final apiProvider = await ApiProvider.init(storageService: storageService);
  locator.registerSingleton<ApiProvider>(apiProvider);
}

Future<void> setupRepositories() async {
  locator.registerSingleton<AuthRepository>(
    AuthRepository(
      apiProvider: locator<ApiProvider>(),
      storageService: locator<StorageService>(),
    ),
  );
}

void setupCubits() {
  locator.registerFactory<LoginCubit>(
    () => LoginCubit(locator<AuthRepository>(), locator<StorageService>()),
  );
  locator.registerFactory<RegisterCubit>(
    () => RegisterCubit(locator<AuthRepository>(), locator<StorageService>()),
  );
}
