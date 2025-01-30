import 'package:esgix_project/model/user.dart';

class Post {
  final User? author; // Optionnel
  final String content; // Requis
  final String? id; // Optionnel
  final String? imageUrl; // Optionnel
  final String? parent; // Optionnel
  final int? commentCount; // Optionnel
  final int? likeCount; // Optionnel
  final bool? likedByUser;
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
    this.likedByUser,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json.containsKey('author') && json['author'] != null
          ? User.fromJson(json['author'])
          : null,
      content: json['content'] as String,
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      parent: json['parent'] as String?,
      commentCount: json['commentsCount'] as int?,
      likeCount: json['likesCount'] as int?,
      likedByUser: json['likedByUser'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (author != null) 'author': author,
      'content': content,
      if (id != null) 'id': id,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (parent != null) 'parent': parent,
      if (commentCount != null) 'commentCount': commentCount,
      if (likeCount != null) 'likeCount': likeCount,
      if (likedByUser != null) 'likedByUser': likedByUser,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }

  Post copyWith({
    User? author,
    String? content,
    String? id,
    String? imageUrl,
    String? parent,
    int? commentCount,
    int? likeCount,
    bool? likedByUser,
    String? createdAt,
    String? updatedAt,
  })
  {
    print("$Post");
    return Post(
      author: author ?? this.author,
      content: content ?? this.content,
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      parent: parent ?? this.parent,
      commentCount: commentCount ?? this.commentCount,
      likeCount: likeCount ?? this.likeCount,
      likedByUser: likedByUser ?? this.likedByUser,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
