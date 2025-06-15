class GeoLocation {
  final String type;
  final double latitude;
  final double longitude;

  GeoLocation({
    this.type = 'Point',
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': [longitude, latitude],
    };
  }

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    final List<dynamic> coordinates = json['coordinates'];
    return GeoLocation(
      type: json['type'] ?? 'Point',
      longitude: (coordinates[0] as num).toDouble(),
      latitude: (coordinates[1] as num).toDouble(),
    );
  }
}
