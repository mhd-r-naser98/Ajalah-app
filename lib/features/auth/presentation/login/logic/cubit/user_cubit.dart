import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import 'package:new_ajalah/features/auth/data/auth_repo.dart';
import 'package:new_ajalah/features/auth/presentation/login/logic/state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final StorageService _storage = locator<StorageService>();
  final AuthRepository _authRepo = locator<AuthRepository>();

  UserCubit() : super(UserInitial());

  Future<void> loadUser() async {
    emit(UserLoading());
    try {
      final user = await _storage.getUser();
      if (user == null) {
        emit(const UserError("لا يوجد مستخدم مسجل"));
      } else {
        emit(UserLoaded(user));
      }
    } catch (e) {
      emit(UserError("حدث خطأ أثناء تحميل المستخدم"));
    }
  }

  Future<bool> logout() async {
    try {
      await _authRepo.logout();
      emit(UserInitial());
      return true;
    } catch (e) {
      emit(UserError("حدث خطأ أثناء تحميل المستخدم"));
      return false;
    }
    // ignore: use_build_context_synchronously
  }
}
