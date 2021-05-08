import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/device_model.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/utilities/user_helper.dart';

class AddNewHubViewModel extends ChangeNotifier{
  bool isLoading = false;

  TextEditingController hubId = TextEditingController();
  TextEditingController hubName = TextEditingController();

  List<DeviceModel>? hubDeviceList;

  AddNewHubViewModel(){
    getHubDevices();
  }

  getHubDevices() async {
    UserModel user = UserHelper().getCachedUser()!;
    var devicesSnap = await FirebaseFirestore.instance.collection("settings")
        .doc("constants")
        .get();
    List<dynamic> list = devicesSnap.data()!["devices"] as List<dynamic>;
    hubDeviceList = [];
    for (var d in list) {
      hubDeviceList!.add(DeviceModel.fromJson(d as Map<String, dynamic>));
    }
    // update device ids
    for (var d in hubDeviceList!) {
      d.id = hubId.text.trim() + "-" + d.id;
      d.hubId = hubId.text.trim();
      d.hubName = hubName.text.trim();
      d.userId = user.id;
      d.status = false;
    }
    notifyListeners();
  }

  Future<bool> addNewHub() async {
    try {
      isLoading = true;
      notifyListeners();
      UserModel user = UserHelper().getCachedUser()!;

      // check whether already exist
      var snap = await FirebaseFirestore.instance.collection("settings")
          .where("hub_id", isEqualTo: hubId.text.trim())
          .get();

      if (snap.docs.length > 0){
        return false;
      }

      // get devices
      var devicesSnap = await FirebaseFirestore.instance.collection("settings")
          .doc("constants")
          .get();
      List<dynamic> list = devicesSnap.data()!["devices"];
      List<DeviceModel> devicesList = [];
      for (var d in list) {
        devicesList.add(DeviceModel.fromJson(d as Map<String, dynamic>));
      }
      // update device ids
      for (var d in devicesList) {
        d.id = hubId.text.trim() + "-" + d.id;
        d.hubId = hubId.text.trim();
        d.hubName = hubName.text.trim();
        d.userId = user.id;
      }

      // create hub
      HubModel hubModel = HubModel(
          id: hubId.text.trim(),
          name: hubName.text.trim(),
          devicesCount: devicesList.length,
          userId: user.id,
          devices: devicesList
      );
      await FirebaseFirestore.instance.collection("hubs").add(
          hubModel.toJson());

      // add devices
      for (var d in devicesList) {
        await FirebaseFirestore.instance.collection("devices").add(d.toJson());
      }
      return true;
    }
    catch(ex){
      print(ex);
      isLoading = false;
      notifyListeners();
    }
    return false;
  }
}