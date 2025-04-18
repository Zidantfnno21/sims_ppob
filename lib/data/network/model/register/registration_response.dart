import 'package:json_annotation/json_annotation.dart';

part 'registration_response.g.dart';

@JsonSerializable()
class RegistrationResponse {
  int status;
  String message;
  String? data;

  RegistrationResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);
}
