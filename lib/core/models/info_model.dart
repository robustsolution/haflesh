class InfoModel {
  final String? uid;
  final List<String>? photos;
  final String? bio;
  final List<String>? prompts;
  final List<String>? answers;

  InfoModel({
    this.uid,
    this.photos,
    this.bio,
    this.prompts,
    this.answers,
  });

  InfoModel copyWith(
      {String? uid,
      List<String>? photos,
      String? bio,
      List<String>? prompts,
      List<String>? answers}) {
    return InfoModel(
        uid: uid ?? this.uid,
        photos: photos ?? this.photos,
        bio: bio ?? this.bio,
        prompts: prompts ?? this.prompts,
        answers: answers ?? this.answers);
  }

  factory InfoModel.fromJson(Map<String, dynamic> map) {
    return InfoModel(
      uid: map['uid'],
      photos: List<String>.from(map['photos'] ?? []),
      bio: map['bio'],
      prompts: List<String>.from(map['prompts'] ?? []),
      answers: List<String>.from(map['answers'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'photos': photos,
        'bio': bio,
        'prompts': prompts,
        'answers': answers,
      };
}
