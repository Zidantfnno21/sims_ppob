// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) =>
    BalanceResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Balance.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BalanceResponseToJson(BalanceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
