class User {
  final String email;
  final String? password;
  final String username;
  final String avatar;
  final String? id;

  const User({
    required this.email,
    required this.avatar,
    required this.password,
    required this.username,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'avatar': avatar,
      if (password != null) 'password': password,
      'username': username,
      if (id != null) 'id': id,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      avatar: json['avatar'],
      password: json['password'],
      username: json['username'],
      id: json['id'],
    );
  }

}
