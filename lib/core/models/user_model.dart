class UserModel {
  final String uid;
  final String? phoneNumber;
  final String? email;
  final String provider;
  final bool isDisabled;

  UserModel({
    required this.uid,
    this.phoneNumber,
    this.email,
    required this.provider,
    required this.isDisabled,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      phoneNumber: map['phone_number'],
      email: map['email'],
      provider: map['provider'],
      isDisabled: map['is_disabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phone_number': phoneNumber,
      'email': email,
      'provider': provider,
      'is_disabled': isDisabled,
    };
  }
}
