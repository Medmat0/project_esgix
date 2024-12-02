class RecordAuthDto {
  final String apiKey;
  final String avatar;
  final String collectionId;
  final String collectionName;
  final String created;
  final String? description;
  final String email;
  final bool emailVisibility;
  final String id;
  final String updated;
  final String username;
  final bool verified;

  const RecordAuthDto({
    required this.apiKey,
    required this.avatar,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    this.description,
    required this.email,
    required this.emailVisibility,
    required this.id,
    required this.updated,
    required this.username,
    required this.verified,
  });

  factory RecordAuthDto.fromJson(Map<String, dynamic> json) {
    return RecordAuthDto(
      apiKey: json["api_key"],
      avatar: json["avatar"],
      collectionId: json['collectionId'],
      collectionName: json["collectionName"],
      created: json["created"],
      description: json["description"],
      email: json["email"],
      emailVisibility: json["emailVisibility"] as bool,
      id: json["id"],
      updated: json["updated"],
      username: json["username"],
      verified: json["verified"] as bool,
    );
  }
}