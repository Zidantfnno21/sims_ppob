// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      invoiceNumber: json['invoice_number'] as String,
      serviceCode: json['service_code'] as String,
      serviceName: json['service_name'] as String,
      transactionType: json['transaction_type'] as String,
      totalAmount: (json['total_amount'] as num).toInt(),
      createdOn: json['created_on'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'invoice_number': instance.invoiceNumber,
      'service_code': instance.serviceCode,
      'service_name': instance.serviceName,
      'transaction_type': instance.transactionType,
      'total_amount': instance.totalAmount,
      'created_on': instance.createdOn,
    };
