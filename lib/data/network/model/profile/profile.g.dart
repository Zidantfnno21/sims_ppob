// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['email'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['profile_image'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'profile_image': instance.profileImage,
    };
