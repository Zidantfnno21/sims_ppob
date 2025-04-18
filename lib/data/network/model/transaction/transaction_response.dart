
import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/transaction/transaction.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse{
  int status;
  String message;
  Transaction? data;

  TransactionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}