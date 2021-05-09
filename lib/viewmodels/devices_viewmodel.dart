import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart' as firebase_database;
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/utilities/user_helper.dart';
import 'package:home_automation_system/utilities/vibrator_helper.dart';
import 'package:intl/intl.dart';

class DevicesViewModel extends ChangeNotifier{
  List<DeviceModel>? devices;
  double totalKwhForToday = 0;

  DevicesViewModel({String? hubId}){
    getDevices(hubId: hubId);
  }
  
  getDevices({String? hubId}) async {
    UserModel user = UserHelper().getCachedUser()!;
    Query query;
    if (hubId != null){
      query = FirebaseFirestore.instance.collection("devices")
          .where("hub_id", isEqualTo: hubId)
          .where("user_id", isEqualTo: user.id);
    }
    else{
      query = FirebaseFirestore.instance.collection("devices")
          .where("user_id", isEqualTo: user.id);
    }

    var snaps = await query.get();
    devices = [];
    snaps.docs.forEach((element) {
      devices!.add(DeviceModel.fromJson(element.data()));
    });

    notifyListeners();

    // getDevice status
    getDeviceStatus();
    getUsage();
  }

  Future<void> getDeviceStatus({String? refreshedItemId}) async {
    if (devices != null && devices!.length > 0){
      for(var device in devices!){
        if (refreshedItemId != null){
          if (device.id == refreshedItemId){
            device.isLoadingStatus = true;
          }
        }
        else {
          device.isLoadingStatus = true;
        }
      }
      notifyListeners();
      for(var device in devices!){
        var result = await firebase_database.FirebaseDatabase.instance.reference().child("devices").child(device.id).child("status")
            .once();
        device.isLoadingStatus = false;
        device.status = result.value;
      }
      notifyListeners();
    }
  }

  Future<void> switchStatus(DeviceModel device) async {
    VibratorHelper().vibrateDelay(5);
    if (device.status != null) {
      device.status = !(device.status!);
    }
    else{
      device.status = true;
    }
    notifyListeners();
    await firebase_database.FirebaseDatabase.instance.reference().child("devices")
        .child(device.id)
        .update({ "status" : device.status});
    getDeviceStatus(refreshedItemId: device.id);

    updateDeviceUsage(device);
  }

  Future<void> updateDeviceUsage(DeviceModel device) async {
    if (device.isContinuouslyRunning) {
      // if on
      if (device.status!) {
        var date = DateTime.now();
        var dateString = DateTime.now().toIso8601String();
        await firebase_database.FirebaseDatabase.instance.reference().child("devices")
            .child(device.id)
            .child("usage")
            .child(date.year.toString())
            .child(date.month.toString())
            .child(date.day.toString())
            .child("data")
            .child("latest")
            .set(dateString);
      }

      // if off
      else {
        // get last turn on time
        var date = DateTime.now();
        var dateString = await firebase_database.FirebaseDatabase.instance.reference().child("devices")
            .child(device.id)
            .child("usage")
            .child(date.year.toString())
            .child(date.month.toString())
            .child(date.day.toString())
            .child("data")
            .child("latest").once();

        if (dateString.value != null){
          var startTimeString = dateString.value;

          var startTime = DateTime.parse(startTimeString);
          var endTime = DateTime.now();
          
          int differenceInSeconds = endTime.difference(startTime).inSeconds;
          double differenceInHours = differenceInSeconds / 3600.00;
          double totalWattHours = differenceInHours * device.watts;

          // calculate usage
          // yearly usage
          var yu = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child("usage")
              .once()).value;
          double yearlyUsage = totalWattHours;
          if (yu != null){
            yearlyUsage += yu;
          }
          // set
          await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child("usage")
              .set(yearlyUsage);


          // monthly usage
          var mu = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child(date.month.toString())
              .child("usage")
              .once()).value;
          double monthlyUsage = totalWattHours;
          if (mu != null){
            monthlyUsage += mu;
          }
          // set
          await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child(date.month.toString())
              .child("usage")
              .set(monthlyUsage);

          // daily usage
          var du = (await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child(date.month.toString())
              .child(date.day.toString())
              .child("usage")
              .once()).value;
          double dailyUsage = totalWattHours;
          if (du != null){
            dailyUsage += du;
          }
          // set
          await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child(date.month.toString())
              .child(date.day.toString())
              .child("usage")
              .set(dailyUsage);

          String formattedTime = DateFormat('HH:mm:ss').format(startTime);
          await firebase_database.FirebaseDatabase.instance.reference().child("devices")
              .child(device.id)
              .child("usage")
              .child(date.year.toString())
              .child(date.month.toString())
              .child(date.day.toString())
              .child("data")
              .child(formattedTime)
              .set(differenceInSeconds);
        }
      }
    }
  }

  Future<void> getUsage() async {
    var date = DateTime.now();
    if (devices != null && devices!.length > 0){
        for(var device in devices!){
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
            totalKwhForToday += (todayUsage / 1000.00);
          }
        }
      notifyListeners();
    }
  }
}