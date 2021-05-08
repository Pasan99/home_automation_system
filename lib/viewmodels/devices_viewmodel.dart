import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_database/firebase_database.dart' as firebase_database;
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/utilities/user_helper.dart';
import 'package:home_automation_system/utilities/vibrator_helper.dart';

class DevicesViewModel extends ChangeNotifier{
  List<DeviceModel>? devices;

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
  }
}