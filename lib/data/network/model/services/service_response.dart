

import 'package:json_annotation/json_annotation.dart';
import 'package:sims_popb/data/network/model/services/service.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  int status;
  String message;
  List<Service>? data;

  ServiceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceResponseToJson(this);
}