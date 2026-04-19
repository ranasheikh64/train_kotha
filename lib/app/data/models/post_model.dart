import 'dart:io';

class Post {
  final String id;
  final String userName;
  final String? userAvatar;
  final String time;
  final String content;
  final String? imageUrl;
  final File? localImage; // For realtime post creation
  final String? locationName;
  int likes;
  int comments;
  int shares;
  bool isLiked;

  Post({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.time,
    required this.content,
    this.imageUrl,
    this.localImage,
    this.locationName,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isLiked = false,
  });
}
