
import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/profile/profile.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  int status;
  String message;
  Profile? data;

  ProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });
  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}