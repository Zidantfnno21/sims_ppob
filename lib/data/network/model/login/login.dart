import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  String email;
  String password;
  
  Login(this.email, this.password);

  factory Login.fromJson(Map<String, dynamic> json) =>
      _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}