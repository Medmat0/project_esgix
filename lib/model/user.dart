class User {
  final String? email; // Rendu optionnel pour gérer son absence
  final String? password; // Optionnel
  final String username; // Requis
  final String avatar; // Requis
  final String? id; // Optionnel
  final String? description; // Optionnel

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
      email: json['email'] as String?, // Nullable cast
      avatar: json['avatar'] as String, // Champ requis
      password: json['password'] as String?, // Nullable cast
      username: json['username'] as String, // Champ requis
      id: json['id'] as String?, // Nullable cast
      description: json['description'] as String?, // Nullable cast
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
