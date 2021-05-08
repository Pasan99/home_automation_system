// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hub_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HubModel _$HubModelFromJson(Map<String, dynamic> json) {
  return HubModel(
    id: json['id'] as String,
    name: json['name'] as String,
    devicesCount: json['devices_count'] as int,
    userId: json['user_id'] as String,
    devices: (json['devices'] as List<dynamic>)
        .map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HubModelToJson(HubModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'devices_count': instance.devicesCount,
      'user_id': instance.userId,
      'devices': instance.devices.map((e) => e.toJson()).toList(),
    };
