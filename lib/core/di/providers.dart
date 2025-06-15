import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/cubit/login_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_ajalah/features/auth/presentation/register/logic/cubit/register_cubit.dart';

final loginCubitProvider = Provider<LoginCubit>((ref) {
  return locator<LoginCubit>();
});

final registerCubitProvider = Provider<RegisterCubit>((ref) {
  return locator<RegisterCubit>();
});
