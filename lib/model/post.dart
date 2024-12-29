import 'package:esgix_project/model/user.dart';

class Post {
  final User? author; // Optionnel
  final String content; // Requis
  final String? id; // Optionnel
  final String? imageUrl; // Optionnel
  final String? parent; // Optionnel
  final int? commentCount; // Optionnel
  final int? likeCount; // Optionnel
  final String? createdAt; // Optionnel
  final String? updatedAt; // Optionnel

  const Post({
    this.author,
    required this.content,
    this.id,
    this.imageUrl,
    this.parent,
    this.commentCount,
    this.likeCount,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json.containsKey('author') && json['author'] != null
          ? User.fromJson(json['author'])
          : null,
      content: json['content'] as String, // Requis, déclenche une erreur si absent
      id: json['id'] as String?, // Nullable cast
      imageUrl: json['imageUrl'] as String?, // Nullable cast
      parent: json['parent'] as String?, // Nullable cast
      commentCount: json['commentsCount'] as int?, // Nullable cast
      likeCount: json['likesCount'] as int?, // Nullable cast
      createdAt: json['createdAt'] as String?, // Nullable cast
      updatedAt: json['updatedAt'] as String?, // Nullable cast
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (author != null) 'author': author,
      'content': content, // Toujours inclus car requis
      if (id != null) 'id': id,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (parent != null) 'parent': parent,
      if (commentCount != null) 'commentCount': commentCount,
      if (likeCount != null) 'likeCount': likeCount,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
