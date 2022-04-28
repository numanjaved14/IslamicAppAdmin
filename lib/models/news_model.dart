class NewsModel {
  final String title;
  final String description;
  final String date;
  final String photoUrl;

  const NewsModel({
    required this.title,
    required this.description,
    required this.date,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'date': date,
        'photoUrl': photoUrl,
      };
}
