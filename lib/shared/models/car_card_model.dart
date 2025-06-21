class CarCardItem {
  final dynamic id;
  final String? link;
  final List<String> gallery;
  final String name;
  final String? description;
  final List<dynamic> tag;
  final String price;
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
}
