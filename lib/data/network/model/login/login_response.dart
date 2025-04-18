
import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/login/token.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  int status;
  String message;
  Token? data;
  
  LoginResponse(this.status, this.message, this.data);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
  
}