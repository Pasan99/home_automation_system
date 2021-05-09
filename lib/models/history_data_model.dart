import 'package:json_annotation/json_annotation.dart';

part 'history_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class HistoryDataModel {
  @JsonKey(name: "date_executed")
  final String date;
  final String hour;
  @JsonKey(name: "timeInSeconds")
  double usage;
  @JsonKey(name: "min_amount")
  final double minAmount;
  @JsonKey(name: "max_amount")
  final double maxAmount;


  HistoryDataModel({required this.date, required this.usage, required this.minAmount, required this.maxAmount, required this.hour});

  factory HistoryDataModel.fromJson(Map<String, dynamic> json) => _$HistoryDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryDataModelToJson(this);
}