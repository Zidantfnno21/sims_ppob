// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Records _$RecordsFromJson(Map<String, dynamic> json) => Records(
      invoiceNumber: json['invoice_number'] as String,
      transactionType: json['transaction_type'] as String,
      description: json['description'] as String,
      totalAmount: (json['total_amount'] as num).toInt(),
      createdAt: json['created_on'] as String,
    );

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'invoice_number': instance.invoiceNumber,
      'transaction_type': instance.transactionType,
      'description': instance.description,
      'total_amount': instance.totalAmount,
      'created_on': instance.createdAt,
    };
