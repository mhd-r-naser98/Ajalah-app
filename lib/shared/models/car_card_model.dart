class CarCardItem {
  final dynamic id;
  final String? link;
  final List<String> gallery;
  final String name;
  final String? description;
  final List<dynamic> tag;
  final int price;
  final String? flagSrc;
  final String? location;
  final String? countryOfOrigin;
  final String? savedVehicleId;
  final bool? isSaved;
  final String? ownerRole;

  CarCardItem({
    this.id,
    this.link,
    required this.gallery,
    required this.name,
    this.description,
    required this.tag,
    required this.price,
    this.flagSrc,
    this.location,
    this.countryOfOrigin,
    this.savedVehicleId,
    this.isSaved,
    this.ownerRole,
  });

  factory CarCardItem.fromJson(Map<String, dynamic> json) {
    return CarCardItem(
      id: json['id'],
      link: json['link'],
      gallery: List<String>.from(json['gallery'] ?? []),
      name: json['name'] ?? '',
      description: json['description'],
      tag: List<dynamic>.from(json['tag'] ?? []),
      price: json['price'] as int,
      flagSrc: json['flagSrc'],
      location: json['location'],
      countryOfOrigin: json['countryOfOrigin'],
      savedVehicleId: json['savedVehicleId'],
      isSaved: json['isSaved'],
      ownerRole: json['ownerRole'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'gallery': gallery,
      'name': name,
      'description': description,
      'tag': tag,
      'price': price,
      'flagSrc': flagSrc,
      'location': location,
      'countryOfOrigin': countryOfOrigin,
      'savedVehicleId': savedVehicleId,
      'isSaved': isSaved,
      'ownerRole': ownerRole,
    };
  }
}
