// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import '../state/login_state.dart';
import '../../../../data/auth_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepo;
  final StorageService _storageService;

  UserLogin way = UserLogin.phone;
  bool rememberMe = false;
  String? savedPhone;
  String? savedEmail;
  String? savedPassword;

  LoginCubit(this._authRepo, this._storageService)
    : super(LoginLoadingInitial()) {
    _loadInitialData();
  }

  Future setWay(UserLogin userWay) async {
    try {
      way = userWay;
      await _storageService.saveWay(userWay);
      emit(LoginInitial(selected: userWay));
    } catch (e) {
      emit(LoginFailure(error: 'فشل تحميل البيانات'));
    }
  }

  Future<void> _loadInitialData() async {
    try {
      rememberMe = await _storageService.getRememberMe() ?? false;
      way = await _storageService.getSavedWay() ?? UserLogin.phone;
      if (rememberMe) {
        savedPhone = await _storageService.getSavedPhone();
        savedEmail = await _storageService.getSavedEmail();
        savedPassword = await _storageService.getSavedPassword();
        print('Saved Phone: $savedPhone');
        print('Saved Email: $savedEmail');
      }
      if (way == UserLogin.phone && (savedEmail?.isNotEmpty ?? false)) {
        way = UserLogin.email;
      } else if (way == UserLogin.email && (savedPhone?.isNotEmpty ?? false)) {
        way = UserLogin.phone;
      }
      emit(
        LoginInitial(
          phone: way == UserLogin.phone ? savedPhone : null,
          email: way == UserLogin.email ? savedEmail : null,
          password: savedPassword,
          rememberMe: rememberMe,
          selected: way,
        ),
      );
    } catch (e) {
      emit(LoginFailure(error: 'فشل تحميل البيانات'));
    }
  }

  void toggleRememberMe(bool value) {
    rememberMe = value;
    if (rememberMe) {
      emit(
        LoginInitial(
          phone: way == UserLogin.phone ? savedPhone : null,
          email: way == UserLogin.email ? savedEmail : null,
          password: savedPassword,
          rememberMe: rememberMe,
          selected: way,
        ),
      );
    } else {
      emit(
        LoginInitial(
          phone: null,
          email: null,
          password: null,
          rememberMe: rememberMe,
          selected: way,
        ),
      );
    }
  }

  Future<void> logIn({
    required String identifier,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await _authRepo.login(phone: identifier, password: password);
      if (rememberMe) {
        if (way == UserLogin.phone) {
          await _storageService.savePhone(identifier);
          await _storageService.saveEmail('');
        } else {
          await _storageService.saveEmail(identifier);
          await _storageService.savePhone('');
        }
        await _storageService.savePassword(password);
        await _storageService.saveRememberMe(rememberMe);
      } else {
        await _storageService.savePhone('');
        await _storageService.saveEmail('');
        await _storageService.savePassword('');
        await _storageService.saveRememberMe(false);
      }
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
