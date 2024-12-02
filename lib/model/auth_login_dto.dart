import 'package:esgix_project/model/record_auth_dto.dart';

class AuthLoginDto {
  final String token;
  final RecordAuthDto record;

  AuthLoginDto({
    required this.token,
    required this.record,
  });

  factory AuthLoginDto.fromJson(Map<String, dynamic> json) {
    return AuthLoginDto(
      token: json['token'],
      record: RecordAuthDto.fromJson(json['record']),
    );
  }
}