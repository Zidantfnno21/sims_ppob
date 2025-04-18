import 'package:json_annotation/json_annotation.dart';

part 'registration.g.dart';

@JsonSerializable()
class Registration{
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  @JsonKey(name: 'password')
  String password;

  Registration(this.email, this.firstName, this.lastName, this.password);

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationToJson(this);

}