
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  @JsonKey(name: "service_code")
  String serviceCode;
  @JsonKey(name: "service_name")
  String serviceName;
  @JsonKey(name: "service_icon")
  String serviceIcon;
  @JsonKey(name: "service_tariff")
  int serviceTariff;

  Service({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}
