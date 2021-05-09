import 'package:flutter/cupertino.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/models/history_data_model.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;
import 'package:intl/intl.dart';

class UsageChartViewModel extends ChangeNotifier{

  List<HistoryDataModel>? data;
  double maxValue = 0;
  double minValue = 0;

  double monthlyUsage = 0;
  double annualUsage = 0;
  double dailyUsage = 0;


  UsageChartViewModel(DeviceModel deviceModel){
    getData(deviceModel);
  }

  Future<void> getData(DeviceModel device) async {
    // today
    var date = DateTime.now();
    var dailyUsage = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
        .child(device.id)
        .child("usage")
        .child(date.year.toString())
        .child(date.month.toString())
        .child(date.day.toString())
        .child("data").once()).value;

    if (dailyUsage != null){
      data = [];
      List<HistoryDataModel> tempData = [];
      double minAmount = 0;
      double maxAmount = 0;
      String formattedDate = DateFormat('yyy-MM-dd HH:mm:ss').format(date);
      for(var key in dailyUsage.keys){
        if (key != "latest") {
          HistoryDataModel model = HistoryDataModel(
            hour: int.parse(key.toString().substring(0, 2)).toString(),
              date: "$formattedDate",
              usage: ((dailyUsage[key]! as int) / 3600.00 *
                  device.watts) / 1000.00,
              minAmount: minAmount,
              maxAmount: maxAmount);
          tempData.add(model);
        }
      }
      for (int i = 0; i< 24; i++){
        data!.add(HistoryDataModel(
            hour: i.toString(),
            date: "$formattedDate",
            usage: 0,
            minAmount: minAmount,
            maxAmount: maxAmount));
      }
      for(var d in tempData){
        for(var d2 in data!){
          if (d.hour == d2.hour) {
            print("hello : " + d.usage.toString());
            d2.usage += d.usage;
          }
        }
      }

      for(var d2 in data!){
        if (d2.usage > maxAmount) {
          maxAmount = d2.usage;
        }
        if (d2.usage < minValue) {
          minValue = d2.usage;
        }
      }
    }
    notifyListeners();
    getUsage(device);
  }

  Future<void> getUsage(DeviceModel device) async {
    var date = DateTime.now();
    var todayUsage = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
        .child(device.id)
        .child("usage")
        .child(date.year.toString())
        .child(date.month.toString())
        .child(date.day.toString())
        .child("usage")
        .once()).value;
    print(todayUsage);
    if (todayUsage != null) {
      dailyUsage = (todayUsage / 1000.00);
    }
    notifyListeners();

    var monthUsage = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
        .child(device.id)
        .child("usage")
        .child(date.year.toString())
        .child(date.month.toString())
        .child("usage")
        .once()).value;
    print(monthUsage);
    if (monthUsage != null) {
      monthlyUsage = (monthUsage / 1000.00);
    }

    notifyListeners();

    var annualUsage1 = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
        .child(device.id)
        .child("usage")
        .child(date.year.toString())
        .child("usage")
        .once()).value;
    print(annualUsage1);
    if (annualUsage1 != null) {
      annualUsage = (annualUsage1 / 1000.00);
    }
    notifyListeners();
  }
}