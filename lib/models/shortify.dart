class Shortify {
  final String id;
  final String title;
  final String destination;
  final String shortUrl;

  Shortify(
      {required this.id,
      required this.title,
      required this.destination,
      required this.shortUrl});

  factory Shortify.fromJson(Map<String, dynamic> json) => Shortify(
      id: json['id'],
      title: json['title'],
      destination: json['destination'],
      shortUrl: json['shortUrl']);
}
