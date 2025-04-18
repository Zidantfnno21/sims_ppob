import 'package:json_annotation/json_annotation.dart';

part 'transaction_service.g.dart';

@JsonSerializable()
class TransactionService {
  @JsonKey(name: 'service_code')
  String serviceCode;

  TransactionService({
    required this.serviceCode,
  });

  factory TransactionService.fromJson(Map<String, dynamic> json) =>
      _$TransactionServiceFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionServiceToJson(this);
}