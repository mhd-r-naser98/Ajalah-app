import 'package:new_ajalah/features/auth/models/address.dart';
import 'dealer_model.dart';

class UserModel {
  final String? userId;
  final String? fName;
  final String? lName;
  final String? email;
  final String? phone;
  final String role;
  final String? coverImageUrl;
  final String? profileImageUrl;
  final Address? address;
  final String? gender;
  final DateTime? birth;
  final DealerModel? dealership;
  final int? vehicleCount;

  const UserModel({
    required this.userId,
    this.fName,
    this.lName,
    this.email,
    this.phone,
    required this.role,
    this.coverImageUrl,
    this.profileImageUrl,
    this.address,
    this.gender,
    this.birth,
    this.dealership,
    this.vehicleCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rawAddress = json['address'];
    final parsedRole = json['role'] ?? '';

    Address? parsedAddress;
    if (parsedRole == 'Seller' && rawAddress is String) {
      parsedAddress = Address(city: rawAddress);
    } else if (rawAddress is Map<String, dynamic>) {
      parsedAddress = Address.fromJson(rawAddress);
    }

    return UserModel(
      userId: json['userId'],
      fName: json['fName'],
      lName: json['lName'],
      email: json['email'],
      phone: json['phone'],
      role: parsedRole,
      coverImageUrl: json['coverImageUrl'],
      profileImageUrl: json['profileImageUrl'],
      address: parsedAddress,
      gender: json['gender'],
      birth: json['birth'] != null ? DateTime.tryParse(json['birth']) : null,
      dealership: json['dealership'] != null
          ? DealerModel.fromJson(json['dealership'])
          : null,
      vehicleCount: json['vehicleCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fName': fName,
      'lName': lName,
      'email': email,
      'phone': phone,
      'role': role,
      'coverImageUrl': coverImageUrl,
      'profileImageUrl': profileImageUrl,
      'address': role == 'Seller' ? address : address?.toJson(),
      'gender': gender,
      'birth': birth?.toIso8601String(),
      'dealership': dealership?.toJson(),
      'vehicleCount': vehicleCount,
    };
  }
}
