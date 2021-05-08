// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) {
  return DeviceModel(
    id: json['id'] as String,
    name: json['name'] as String,
    deviceType: json['device_type'] as String,
    hubId: json['hub_id'] as String?,
    hubName: json['hub_name'] as String?,
    status: json['status'] as bool?,
    userId: json['user_id'] as String?,
  )..isLoadingStatus = json['isLoadingStatus'] as bool?;
}

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hub_id': instance.hubId,
      'hub_name': instance.hubName,
      'device_type': instance.deviceType,
      'user_id': instance.userId,
      'status': instance.status,
      'isLoadingStatus': instance.isLoadingStatus,
    };
