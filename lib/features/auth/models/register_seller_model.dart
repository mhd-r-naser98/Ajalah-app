class RegisterSellerModel {
  final String fName;
  final String lName;
  final String password;
  final String phone;
  final String? email;
  final String? birth;
  final String city;
  final String? gender;

  RegisterSellerModel({
    required this.fName,
    required this.lName,
    required this.password,
    required this.phone,
    this.email,
    this.birth,
    required this.city,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'fName': fName,
      'lName': lName,
      'password': password,
      'phone': phone,
      if (email != null) 'email': email,
      if (birth != null) 'birth': birth,
      'city': city,
      if (gender != null) 'gender': gender,
    };
  }
}
