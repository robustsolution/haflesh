class ProfileModel {
  final String? uid; // firebase auth uid will be primary key
  final String? firstname;
  final String? lastname;
  final DateTime? birthday;
  final String? gender;
  final bool? genderVisibility;
  final String? town;
  final bool? townVisibility;
  final String? religious;
  final bool? religiousVisibility;
  final String? smoke;
  final bool? smokeVisibility;
  final String? drink;
  final bool? drinkVisibility;
  final String? drug;
  final bool? drugVisibility;
  final String? ethnicity;
  final bool? ethnicityVisibility;
  final String? pronoun;
  final bool? pronounVisibility;
  final int? height;
  final bool? heightVisibility;
  final List<String>? photos;
  final String? bio;
  final List<String>? prompts;
  final List<String>? answers;
  final List<int>? agePreferences;
  final double? distancePreference;
  final String? distanceUnit;
  final List<String>? spotifySongs;
  final String? tiktok;
  final String? meme;
  final String? movie;
  final bool? zodiacVisibility;
  final List<String>? iAmHereTo;

  ProfileModel(
      {this.uid,
      this.firstname,
      this.lastname,
      this.birthday,
      this.gender,
      this.genderVisibility,
      this.town,
      this.townVisibility,
      this.religious,
      this.religiousVisibility,
      this.smoke,
      this.smokeVisibility,
      this.drink,
      this.drinkVisibility,
      this.drug,
      this.drugVisibility,
      this.ethnicity,
      this.ethnicityVisibility,
      this.pronoun,
      this.pronounVisibility,
      this.height,
      this.heightVisibility,
      this.photos,
      this.bio,
      this.prompts,
      this.answers,
      this.agePreferences,
      this.distancePreference,
      this.distanceUnit,
      this.spotifySongs,
      this.tiktok,
      this.meme,
      this.movie,
      this.zodiacVisibility,
      this.iAmHereTo});

  ProfileModel copyWith(
      {String? uid,
      String? firstname,
      String? lastname,
      DateTime? birthday,
      String? gender,
      bool? genderVisibility,
      String? town,
      bool? townVisibility,
      String? religious,
      bool? religiousVisibility,
      String? smoke,
      bool? smokeVisibility,
      String? drink,
      bool? drinkVisibility,
      String? drug,
      bool? drugVisibility,
      String? ethnicity,
      bool? ethnicityVisibility,
      String? pronoun,
      bool? pronounVisibility,
      int? height,
      bool? heightVisibility,
      List<String>? photos,
      String? bio,
      List<String>? prompts,
      List<String>? answers,
      List<int>? agePreferences,
      double? distancePreference,
      String? distanceUnit,
      List<String>? spotifySongs,
      String? tiktok,
      String? meme,
      String? movie,
      bool? zodiacVisibility,
      List<String>? iAmHereTo}) {
    return ProfileModel(
        uid: uid ?? this.uid,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        genderVisibility: genderVisibility ?? this.genderVisibility,
        town: town ?? this.town,
        townVisibility: townVisibility ?? this.townVisibility,
        religious: religious ?? this.religious,
        religiousVisibility: religiousVisibility ?? this.religiousVisibility,
        smoke: smoke ?? this.smoke,
        smokeVisibility: smokeVisibility ?? this.smokeVisibility,
        drink: drink ?? this.drink,
        drinkVisibility: drinkVisibility ?? this.drinkVisibility,
        drug: drug ?? this.drug,
        drugVisibility: drugVisibility ?? this.drugVisibility,
        ethnicity: ethnicity ?? this.ethnicity,
        ethnicityVisibility: ethnicityVisibility ?? this.ethnicityVisibility,
        pronoun: pronoun ?? this.pronoun,
        pronounVisibility: pronounVisibility ?? this.pronounVisibility,
        height: height ?? this.height,
        photos: photos ?? this.photos,
        bio: bio ?? this.bio,
        prompts: prompts ?? this.prompts,
        answers: answers ?? this.answers,
        agePreferences: agePreferences ?? this.agePreferences,
        distancePreference: distancePreference ?? this.distancePreference,
        distanceUnit: distanceUnit ?? this.distanceUnit,
        spotifySongs: spotifySongs ?? this.spotifySongs,
        tiktok: tiktok ?? this.tiktok,
        meme: meme ?? this.meme,
        movie: movie ?? this.movie,
        zodiacVisibility: zodiacVisibility ?? this.zodiacVisibility,
        iAmHereTo: iAmHereTo ?? this.iAmHereTo);
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
      religious: map['religious'],
      religiousVisibility: map['religious_visibility'],
      smoke: map['smoke'],
      smokeVisibility: map['smoke_visibility'],
      drink: map['drink'],
      drinkVisibility: map['drink_visibility'],
      drug: map['drug'],
      drugVisibility: map['drug_visibility'],
      ethnicity: map['ethinicity'],
      ethnicityVisibility: map['ethnicity_visibility'],
      pronoun: map['pronoun'],
      pronounVisibility: map['pronoun_visibility'],
      height: map['height'],
      heightVisibility: map['height_visibility'],
      photos: List<String>.from(map['photos'] ?? []),
      bio: map['bio'],
      prompts: List<String>.from(map['prompts'] ?? []),
      answers: List<String>.from(map['answers'] ?? []),
      agePreferences: List<int>.from(map['age_preferences'] ?? []),
      distancePreference: map['distance_preference'],
      distanceUnit: map['distance_unit'],
      spotifySongs: List<String>.from(map['spotify_songs'] ?? []),
      tiktok: map['tiktok'],
      meme: map['meme'],
      movie: map['movie'],
      zodiacVisibility: map['zodiac_visibility'],
      iAmHereTo: List<String>.from(map['i_am_here_to'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'firstname': firstname,
        'lastname': lastname,
        'birthday': birthday?.toString(),
        'gender': gender,
        'gender_visibility': genderVisibility,
        'religious': religious,
        'religious_visibility': religiousVisibility,
        'smoke': smoke,
        'smoke_visibility': smokeVisibility,
        'drink': drink,
        'drink_visibility': drinkVisibility,
        'drug': drug,
        'drug_visibility': drugVisibility,
        'ethnicity': ethnicity,
        'ethnicity_visibility': ethnicityVisibility,
        'pronoun': pronoun,
        'pronoun_visibility': pronounVisibility,
        'height': height,
        'height_visibility': heightVisibility,
        'photos': photos,
        'bio': bio,
        'prompts': prompts,
        'answers': answers,
        'age_preferences': agePreferences,
        'distance_preference': distancePreference,
        'distance_unit': distanceUnit,
        'spotify_songs': spotifySongs,
        'tiktok': tiktok,
        'meme': meme,
        'movie': movie,
        'zodiac_visibility': zodiacVisibility,
        'i_am_here_to': iAmHereTo,
      };
}
