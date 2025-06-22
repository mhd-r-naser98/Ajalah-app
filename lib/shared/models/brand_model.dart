class BrandModel {
  final String brandId;
  final String name;
  final String brandImageUrl;
  final int isDeleted;

  BrandModel({
    required this.brandId,
    required this.name,
    required this.brandImageUrl,
    required this.isDeleted,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandId: json['brandId'] as String,
      name: json['name'] as String,
      brandImageUrl: json['brandImageUrl'] as String,
      isDeleted: json['isDeleted'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'name': name,
      'brandImageUrl': brandImageUrl,
      'isDeleted': isDeleted,
    };
  }
}
