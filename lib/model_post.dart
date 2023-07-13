class Post {
  final String username;
  final String picture;
  final String caption;
  final String title;

  Post(
      {
      required this.username,
      required this.picture,
      required this.caption,
      required this.title
      });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        username: json['user']['name'],
        picture: "https://b517-103-17-77-3.ngrok-free.app/storage/images/${json['picture']}",
        caption: json['content'],
        title: json['title']
        );
  }
}