// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) {
  return DeviceModel(
    id: json['id'] as String,
    name: json['name'] as String,
    macAddress: json['mac_address'] as String,
    deviceType: json['device_type'] as String,
  );
}

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mac_address': instance.macAddress,
      'device_type': instance.deviceType,
    };
