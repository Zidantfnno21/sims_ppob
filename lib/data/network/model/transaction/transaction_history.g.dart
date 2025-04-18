// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistory _$TransactionHistoryFromJson(Map<String, dynamic> json) =>
    TransactionHistory(
      offset: json['offset'] as String,
      limit: json['limit'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) => Records.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionHistoryToJson(TransactionHistory instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'records': instance.records,
    };
