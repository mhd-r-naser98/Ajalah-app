import 'package:equatable/equatable.dart';

enum UserRole { seller, dealer }

class RegisterStepsData extends Equatable {
  final UserRole? role;
  final String phone;
  final bool agreed;

  const RegisterStepsData({
    this.role = UserRole.seller,
    this.phone = '',
    this.agreed = false,
  });

  RegisterStepsData copyWith({UserRole? role, String? phone, bool? agreed}) {
    return RegisterStepsData(
      role: role ?? this.role,
      phone: phone ?? this.phone,
      agreed: agreed ?? this.agreed,
    );
  }

  @override
  List<Object?> get props => [role, phone, agreed];
}
