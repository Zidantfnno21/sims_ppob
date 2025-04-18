
import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/transaction/transaction_history.dart';

part 'transaction_history_response.g.dart';

@JsonSerializable()
class TransactionHistoryResponse {
  int status;
  String message;
  TransactionHistory? data;

  TransactionHistoryResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$TransactionHistoryResponseToJson(this);
}