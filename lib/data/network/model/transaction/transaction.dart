import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  @JsonKey(name: "invoice_number" )
  String invoiceNumber;
  @JsonKey(name: "service_code" )
  String serviceCode;
  @JsonKey(name: "service_name" )
  String serviceName;
  @JsonKey(name: "transaction_type" )
  String transactionType;
  @JsonKey(name: "total_amount" )
  int totalAmount;
  @JsonKey(name: "created_on" )
  String createdOn;

  Transaction({
    required this.invoiceNumber,
    required this.serviceCode,
    required this.serviceName,
    required this.transactionType,
    required this.totalAmount,
    required this.createdOn,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}