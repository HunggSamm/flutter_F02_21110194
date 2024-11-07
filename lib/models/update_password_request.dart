import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
  final String username;
  final String newPassword;
  final String confirmPassword;

  UpdatePasswordRequest({
    required this.username,
    required this.newPassword,
    required this.confirmPassword,
  });

  // From JSON
  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) => _$UpdatePasswordRequestFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}