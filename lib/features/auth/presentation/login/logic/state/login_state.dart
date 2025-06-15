enum UserLogin { phone, email }

sealed class LoginState {
  const LoginState();
}

class LoginLoadingInitial extends LoginState {}

class LoginInitial extends LoginState {
  final UserLogin? selected;
  final String? email;
  final String? phone;
  final String? password;
  final bool rememberMe;

  LoginInitial({
    this.email,
    this.phone,
    this.password,
    this.rememberMe = false,
    this.selected = UserLogin.phone,
  });
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
