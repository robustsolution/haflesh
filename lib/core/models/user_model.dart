class UserModel {
  final String uid;
  final String provider;
  final String? phoneNumber;

  UserModel({
    required this.uid,
    required this.provider,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      provider: json['provider'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'provider': provider,
      'phone_number': phoneNumber,
    };
  }
}
