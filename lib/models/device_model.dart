import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceModel {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "hub_id")
  String? hubId;
  @JsonKey(name: "hub_name")
  String? hubName;
  @JsonKey(name: "device_type")
  String deviceType;
  @JsonKey(name: "user_id")
  String? userId;

  bool? status = false;
  bool? isLoadingStatus = true;


  DeviceModel( {required this.id, required this.name, required this.deviceType, required this.hubId, required this.hubName, this.status, required this.userId});

  factory DeviceModel.fromJson(Map<String, dynamic> json) => _$DeviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceModelToJson(this);
}