
import 'package:json_annotation/json_annotation.dart';
import 'banner.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  int status;
  String message;
  List<Banner>? data;

  BannerResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}