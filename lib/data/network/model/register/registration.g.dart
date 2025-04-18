// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registration _$RegistrationFromJson(Map<String, dynamic> json) => Registration(
      json['email'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$RegistrationToJson(Registration instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'password': instance.password,
    };
