import 'package:new_ajalah/features/auth/models/address.dart';
import 'package:new_ajalah/features/auth/models/geo_location.dart';

class RegisterDealerModel {
  final String tradingName;
  final String phone;
  final String password;
  final String? description;
  final String? email;
  final String? website;
  final Address address;
  final GeoLocation geoLocation;

  RegisterDealerModel({
    this.email,
    required this.phone,
    required this.password,
    required this.tradingName,
    this.description,
    this.website,
    required this.address,
    required this.geoLocation,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'password': password,
      'tradingName': tradingName,
      'description': description,
      'website': website,
      'address': address.toJson(),
      'geoLocation': geoLocation.toJson(),
    };
  }
}
