class Address {
  final String? street;
  final String? city;

  Address({this.street, this.city});

  Map<String, dynamic> toJson() {
    return {'street': street, 'city': city};
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(street: json['street'] ?? '', city: json['city'] ?? '');
  }
}
