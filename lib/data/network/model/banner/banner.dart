import 'package:json_annotation/json_annotation.dart';

part 'banner.g.dart';

@JsonSerializable()
class Banner {
  @JsonKey(name:'banner_name')
  String bannerName;
  @JsonKey(name:'banner_image')
  String bannerImage;
  String description;

  Banner({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  factory Banner.fromJson(Map<String, dynamic> json) =>
      _$BannerFromJson(json);
  Map<String, dynamic> toJson() => _$BannerToJson(this);

}