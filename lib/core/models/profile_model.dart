class ProfileModel {
  final String? uid; // firebase auth uid will be primary key
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
  final List<String>? photos;
  final String? bio;
  final List<String>? prompts;
  final List<String>? answers;

  ProfileModel({
    this.uid,
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
    this.photos,
    this.bio,
    this.prompts,
    this.answers,
  });

  ProfileModel copyWith(
      {String? uid,
      String? firstname,
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
      bool? heightVisibility,
      List<String>? photos,
      String? bio,
      List<String>? prompts,
      List<String>? answers}) {
    return ProfileModel(
        uid: uid ?? this.uid,
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
        drugVisibility: drugVisibility ?? this.drugVisibility,
        photos: photos ?? this.photos,
        bio: bio ?? this.bio,
        prompts: prompts ?? this.prompts,
        answers: answers ?? this.answers);
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      birthday:
          map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
      gender: map['gender'],
      genderVisibility: map['gender_visibility'],
      town: map['town'],
      townVisibility: map['town_visibility'],
      nation: map['nation'],
      nationVisibility: map['nation_visibility'],
      religious: map['religious'],
      religiousVisibility: map['religious_visibility'],
      smoke: map['smoke'],
      smokeVisibility: map['smoke_visibility'],
      drink: map['drink'],
      drinkVisibility: map['drink_visibility'],
      drug: map['drug'],
      drugVisibility: map['drug_visibility'],
      photos: List<String>.from(map['photos'] ?? []),
      bio: map['bio'],
      prompts: List<String>.from(map['prompts'] ?? []),
      answers: List<String>.from(map['answers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday?.toString(),
        'gender': gender,
        'gender_visibility': genderVisibility,
        'town': town,
        'town_visibility': townVisibility,
        'nation': nation,
        'nation_visibility': nationVisibility,
        'religious': religious,
        'religious_visibility': religiousVisibility,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility,
        'drink': drink,
        'drink_visibility': drinkVisibility,
        'drug': drug,
        'drug_visibility': drugVisibility,
        'photos': photos,
        'bio': bio,
        'prompts': prompts,
        'answers': answers,
      };
}
