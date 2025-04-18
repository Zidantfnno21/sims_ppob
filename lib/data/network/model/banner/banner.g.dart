// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
      bannerName: json['banner_name'] as String,
      bannerImage: json['banner_image'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'banner_name': instance.bannerName,
      'banner_image': instance.bannerImage,
      'description': instance.description,
    };
