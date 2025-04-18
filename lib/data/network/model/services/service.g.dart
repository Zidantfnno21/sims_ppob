// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      serviceCode: json['service_code'] as String,
      serviceName: json['service_name'] as String,
      serviceIcon: json['service_icon'] as String,
      serviceTariff: (json['service_tariff'] as num).toInt(),
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'service_code': instance.serviceCode,
      'service_name': instance.serviceName,
      'service_icon': instance.serviceIcon,
      'service_tariff': instance.serviceTariff,
    };
