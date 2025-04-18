
import 'package:json_annotation/json_annotation.dart';

part 'update_profile.g.dart';

@JsonSerializable()
class UpdateProfile {
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;

  UpdateProfile({
    required this.firstName,
    required this.lastName,
  });
  factory UpdateProfile.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProfileToJson(this);
}