import 'package:home_automation_system/models/device_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hub_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HubModel {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "devices_count")
  final int devicesCount;
  @JsonKey(name: "user_id")
  final String userId;
  @JsonKey(name: "devices")
  final List<DeviceModel> devices;


  HubModel( {required this.id, required this.name, required this.devicesCount, required this.userId, required this.devices});

  factory HubModel.fromJson(Map<String, dynamic> json) => _$HubModelFromJson(json);
  Map<String, dynamic> toJson() => _$HubModelToJson(this);
}