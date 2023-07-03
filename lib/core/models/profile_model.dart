import 'dart:convert';

class ProfileModel {
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final String? gender;
  final bool? genderVisibility;
  final String? town;
  final bool? townVisibility;
  final List<String>? nation;
  final bool? nationVisibility;
  final String? religious;
  final bool? religiousVisibility;
  final String? smoke;
  final bool? smokeVisibility;
  final String? drink;
  final bool? drinkVisibility;
  final String? drug;
  final bool? drugVisibility;

  ProfileModel({
    this.firstname,
    this.lastname,
    this.birthday,
    this.gender,
    this.genderVisibility,
    this.town,
    this.townVisibility,
    this.nation,
    this.nationVisibility,
    this.religious,
    this.religiousVisibility,
    this.smoke,
    this.smokeVisibility,
    this.drink,
    this.drinkVisibility,
    this.drug,
    this.drugVisibility,
  });

  ProfileModel copyWith(
      {String? firstname,
      String? lastname,
      DateTime? birthday,
      String? gender,
      bool? genderVisibility,
      String? town,
      bool? townVisibility,
      List<String>? nation,
      bool? nationVisibility,
      String? religious,
      bool? religiousVisibility,
      String? smoke,
      bool? smokeVisibility,
      String? drink,
      bool? drinkVisibility,
      String? drug,
      bool? drugVisibility,
      String? pronoun,
      bool? pronounVisibility,
      int? height,
      bool? heightVisibility}) {
    return ProfileModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        genderVisibility: genderVisibility ?? this.genderVisibility,
        town: town ?? this.town,
        townVisibility: townVisibility ?? this.townVisibility,
        nation: nation ?? this.nation,
        nationVisibility: nationVisibility ?? this.nationVisibility,
        religious: religious ?? this.religious,
        religiousVisibility: religiousVisibility ?? this.religiousVisibility,
        smoke: smoke ?? this.smoke,
        smokeVisibility: smokeVisibility ?? this.smokeVisibility,
        drink: drink ?? this.drink,
        drinkVisibility: drinkVisibility ?? this.drinkVisibility,
        drug: drug ?? this.drug,
        drugVisibility: drugVisibility ?? this.drugVisibility);
  }

  factory ProfileModel.fromSnapshot(Map<String, dynamic> snapsot) {
    return ProfileModel(
        firstname: snapsot['firstname'],
        lastname: snapsot['lastname'],
        birthday: snapsot['birthday'] != null
            ? DateTime.parse(snapsot['birthday'])
            : null,
        gender: snapsot['gender'],
        genderVisibility: snapsot['gender_visibility'],
        town: snapsot['town'],
        townVisibility: snapsot['town_visibility'],
        nation: List<String>.from(jsonDecode(snapsot['nation']) ?? []),
        nationVisibility: snapsot['nation_visibility'],
        religious: snapsot['religious'],
        religiousVisibility: snapsot['religious_visibility'],
        smoke: snapsot['smoke'],
        smokeVisibility: snapsot['smoke_visibility'],
        drink: snapsot['drink'],
        drinkVisibility: snapsot['drink_visibility'],
        drug: snapsot['drug'],
        drugVisibility: snapsot['drug_visibility']);
  }

  Map<String, dynamic> toMap() => {
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday?.toString(),
        'gender': gender,
        'gender_visibility': genderVisibility ?? false,
        'town': town,
        'town_visibility': townVisibility ?? false,
        'nation': nation,
        'nation_visibility': nationVisibility ?? false,
        'religious': religious,
        'religious_visibility': religiousVisibility ?? false,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility ?? false,
        'drink': drink,
        'drink_visibility': drinkVisibility ?? false,
        'drug': drug,
        'drug_visibility': drugVisibility ?? false
      };
}
