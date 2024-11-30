class Post {
  final String author;
  final String content;
  final String id;
  final String? imageUrl;
  final String? parent;

  const Post({
    required this.author,
    required this.content,
    required this.id,
    this.imageUrl,
    this.parent,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      author: json['author'],
      content: json['content'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      parent: json['parent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'imageUrl': imageUrl,
      'parent': parent,
    };
  }
}
