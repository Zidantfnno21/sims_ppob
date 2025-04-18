import 'package:json_annotation/json_annotation.dart';

import 'balance.dart';


part 'balance_response.g.dart';

@JsonSerializable()
class BalanceResponse {
  int status;
  String message;
  Balance? data;

  BalanceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);

}