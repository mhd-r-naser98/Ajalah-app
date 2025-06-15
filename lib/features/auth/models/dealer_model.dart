import 'package:new_ajalah/features/auth/models/address.dart';
import 'package:new_ajalah/features/auth/models/geo_location.dart';
import 'package:new_ajalah/features/auth/models/opening_hours.dart';

class DealerModel {
  final String dealershipId;
  final String tradingName;
  final String? description;
  final String? website;
  final Address? address;
  final GeoLocation? geoLocation;
  final List<OpeningHour>? openingHours;
  final int reviews;

  DealerModel({
    required this.dealershipId,
    required this.tradingName,
    this.description,
    this.website,
    this.address,
    this.geoLocation,
    this.openingHours,
    required this.reviews,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) {
    return DealerModel(
      dealershipId: json['dealershipId'],
      tradingName: json['tradingName'],
      description: json['description'],
      website: json['website'],
      address: json['address'] != null
          ? Address.fromJson(json['address'])
          : null,
      geoLocation: json['geoLocation'] != null
          ? GeoLocation.fromJson(json['geoLocation'])
          : null,
      openingHours: json['openingHours'] != null
          ? List<OpeningHour>.from(
              json['openingHours'].map((e) => OpeningHour.fromJson(e)),
            )
          : null,
      reviews: json['reviews'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dealershipId': dealershipId,
      'tradingName': tradingName,
      'description': description,
      'website': website,
      'address': address?.toJson(),
      'geoLocation': geoLocation?.toJson(),
      'openingHours': openingHours?.map((e) => e.toJson()).toList(),
      'reviews': reviews,
    };
  }
}
