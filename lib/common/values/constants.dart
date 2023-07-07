// ignore_for_file: non_constant_identifier_names

class Constants {
  static DateTime release_date = DateTime(2023, 7, 10);
}

class Media {
  final int index;
  final String type;
  final String media;
  final String thumbnail;
  final String duration;

  const Media({
    required this.index,
    required this.type,
    required this.media,
    required this.thumbnail,
    required this.duration,
  });
}
