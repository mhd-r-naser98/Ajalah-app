import '../../core/di/service_locator.dart';
import '../../features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/register/logic/cubit/register_cubit.dart';

final loginCubitProvider = Provider<LoginCubit>((ref) {
  return locator<LoginCubit>();
});

final registerCubitProvider = Provider<RegisterCubit>((ref) {
  return locator<RegisterCubit>();
});
