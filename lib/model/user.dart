class User {
  final String? email;
  final String? password;
  final String username;
  final String avatar;
  final String? id;
  final String? description;

  const User({
    this.email,
    this.password,
    required this.username,
    required this.avatar,
    this.id,
    this.description,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String?,
      avatar: json['avatar'] as String,
      password: json['password'] as String?,
      username: json['username'] as String,
      id: json['id'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      'username': username,
      'avatar': avatar,
      if (id != null) 'id': id,
      if (description != null) 'description': description,
    };
  }
}
