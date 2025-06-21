import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/models/user_model.dart';
import '../../features/auth/presentation/login/logic/state/login_state.dart';

abstract class StorageService {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<UserLogin?> getSavedWay();
  Future<void> removeToken();
  Future<void> saveUser(UserModel user);
  Future<void> saveWay(UserLogin way);
  Future<UserModel?> getUser();
  Future<void> saveLanguage(String languageCode);
  Future<void> saveEmail(String email);
  Future<String?> getSavedLanguage();
  Future<String?> getSavedEmail();

  Future<void> saveThemeMode(bool isDark);
  Future<bool?> getSavedThemeMode();

  Future<void> saveRememberMe(bool value);
  Future<bool?> getRememberMe();
  Future<void> savePhone(String phone);
  Future<void> removePhone();
  Future<String?> getSavedPhone();

  Future<void> savePassword(String password);
  Future<String?> getSavedPassword();
}

class SecureStorageService implements StorageService {
  final FlutterSecureStorage _storage;
  SecureStorageService._(this._storage);

  // static final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'access_token';
  static const _languageKey = 'language';
  static const _themeKey = 'theme_mode';
  static const _rememberMeKey = 'remember_me';
  static const _phoneKey = 'phone';
  static const _emailKey = 'email';
  static const _passwordKey = 'password';
  static const _userKey = 'user';
  static const _selectedWay = 'way';
  static Future<SecureStorageService> create() async {
    return SecureStorageService._(const FlutterSecureStorage());
  }

  @override
  Future<void> savePhone(String phone) async {
    await _storage.write(key: _phoneKey, value: phone);
  }

  @override
  Future<void> saveWay(UserLogin way) async {
    await _storage.write(
      key: _selectedWay,
      value: way == UserLogin.phone ? 'phone' : 'email',
    );
  }

  @override
  Future<UserLogin?> getSavedWay() async {
    var userway = await _storage.read(key: _selectedWay);
    return userway == 'phone' ? UserLogin.phone : UserLogin.email;
  }

  @override
  Future<void> saveEmail(String phone) async {
    await _storage.write(key: _emailKey, value: phone);
  }

  @override
  Future<void> removePhone() async {
    await _storage.delete(key: _phoneKey);
  }

  @override
  Future<String?> getSavedPhone() async {
    return await _storage.read(key: _phoneKey);
  }

  @override
  Future<String?> getSavedEmail() async {
    return await _storage.read(key: _emailKey);
  }

  @override
  Future<void> savePassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  @override
  Future<String?> getSavedPassword() async {
    return await _storage.read(key: _passwordKey);
  }

  @override
  Future<void> saveRememberMe(bool value) async {
    await _storage.write(key: _rememberMeKey, value: value ? '1' : '0');
  }

  @override
  Future<bool?> getRememberMe() async {
    final val = await _storage.read(key: _rememberMeKey);
    if (val == null) return null;
    return val == '1';
  }

  @override
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await _storage.write(key: _userKey, value: jsonString);
  }

  @override
  Future<UserModel?> getUser() async {
    final raw = await _storage.read(key: _userKey);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return UserModel.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await _storage.write(key: _languageKey, value: languageCode);
  }

  @override
  Future<String?> getSavedLanguage() async {
    return await _storage.read(key: _languageKey);
  }

  @override
  Future<void> saveThemeMode(bool isDark) async {
    await _storage.write(key: _themeKey, value: isDark ? '1' : '0');
  }

  @override
  Future<bool?> getSavedThemeMode() async {
    final val = await _storage.read(key: _themeKey);
    if (val == null) return null;
    return val == '1';
  }
}
