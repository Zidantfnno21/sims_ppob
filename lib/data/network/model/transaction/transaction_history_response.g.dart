// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryResponse _$TransactionHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryResponse(
      status: (json['status'] as num).toInt(),
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : TransactionHistory.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionHistoryResponseToJson(
        TransactionHistoryResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
