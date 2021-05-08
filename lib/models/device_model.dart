import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "mac_address")
  final String macAddress;
  @JsonKey(name: "device_type")
  final String deviceType;


  DeviceModel( {required this.id, required this.name, required this.macAddress, required this.deviceType,});

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}