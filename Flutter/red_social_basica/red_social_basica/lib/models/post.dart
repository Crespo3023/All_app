class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  int likes;
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.likes = 0,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      likes: 0,
    );
  }

  get isLiked => null;

  set isliked(bool isliked) {}
}
