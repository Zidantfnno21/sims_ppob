import 'package:json_annotation/json_annotation.dart';

part 'records.g.dart';

@JsonSerializable()
class Records {
  @JsonKey(name: "invoice_number" )
  String invoiceNumber;
  @JsonKey(name: "transaction_type" )
  String transactionType;
  @JsonKey(name: "description" )
  String description;
  @JsonKey(name: "total_amount" )
  int totalAmount;
  @JsonKey(name: "created_on" )
  String createdAt;

  Records({
    required this.invoiceNumber,
    required this.transactionType,
    required this.description,
    required this.totalAmount,
    required this.createdAt,
  });

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);
  Map<String, dynamic> toJson() => _$RecordsToJson(this);
}