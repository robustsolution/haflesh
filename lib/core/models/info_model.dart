class InfoModel {
  final List<String>? photos;
  final String? bio;
  final List<String>? prompts;
  final List<String>? answers;

  InfoModel({
    this.photos,
    this.bio,
    this.prompts,
    this.answers,
  });

  InfoModel copyWith(
      {List<String>? photos,
      String? bio,
      List<String>? prompts,
      List<String>? answers}) {
    return InfoModel(
        photos: photos ?? this.photos,
        bio: bio ?? this.bio,
        prompts: prompts ?? this.prompts,
        answers: answers ?? this.answers);
  }

  factory InfoModel.fromSnapsot(Map<String, dynamic> snapshot) {
    return InfoModel(
      photos: List<String>.from(snapshot['photos'] ?? []),
      bio: snapshot['bio'],
      prompts: List<String>.from(snapshot['prompts'] ?? []),
      answers: List<String>.from(snapshot['answers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'photos': photos,
        'bio': bio,
        'prompts': prompts,
        'answers': answers,
      };
}
