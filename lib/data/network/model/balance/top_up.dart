
import 'package:json_annotation/json_annotation.dart';

part 'top_up.g.dart';

@JsonSerializable()
class TopUp {
  @JsonKey(name: 'top_up_amount')
  int amount;

  TopUp({
    required this.amount,
  });
  
  factory TopUp.fromJson(Map<String, dynamic> json) => _$TopUpFromJson(json);
  Map<String, dynamic> toJson() => _$TopUpToJson(this);
}