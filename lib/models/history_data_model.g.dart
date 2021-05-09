// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDataModel _$HistoryDataModelFromJson(Map<String, dynamic> json) {
  return HistoryDataModel(
    date: json['date_executed'] as String,
    usage: (json['timeInSeconds'] as num).toDouble(),
    minAmount: (json['min_amount'] as num).toDouble(),
    maxAmount: (json['max_amount'] as num).toDouble(),
    hour: json['hour'] as String,
  );
}

Map<String, dynamic> _$HistoryDataModelToJson(HistoryDataModel instance) =>
    <String, dynamic>{
      'date_executed': instance.date,
      'hour': instance.hour,
      'timeInSeconds': instance.usage,
      'min_amount': instance.minAmount,
      'max_amount': instance.maxAmount,
    };
