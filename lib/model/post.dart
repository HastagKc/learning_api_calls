import 'dart:convert';

class Post {
  final int userId;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.title,
    required this.body,
  });

  // create factory constructor

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );
}
