
import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/transaction/records.dart';

part 'transaction_history.g.dart';

@JsonSerializable()
class TransactionHistory {
  String offset;
  String limit;
  List<Records> records;

  TransactionHistory({
    required this.offset,
    required this.limit,
    required this.records,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionHistoryToJson(this);
}