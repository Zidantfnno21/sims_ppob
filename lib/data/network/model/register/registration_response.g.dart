// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
