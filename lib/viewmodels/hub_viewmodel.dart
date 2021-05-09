import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/utilities/user_helper.dart';

class HubViewModel extends ChangeNotifier{
  List<HubModel>? hubs;
  double totalKwhForToday = 0;

  HubViewModel(){
    getHubs();
  }

  Future<void> getHubs() async {
    UserModel user = UserHelper().getCachedUser()!;
    Query query = FirebaseFirestore.instance.collection("hubs")
        .where("user_id", isEqualTo: user.id);

    var snaps = await query.get();
    hubs = [];
    snaps.docs.forEach((element) {
      hubs!.add(HubModel.fromJson(element.data()));
    });
    notifyListeners();

    getUsage();
  }

  Future<void> getUsage() async {
    var date = DateTime.now();
    if (hubs != null && hubs!.length > 0){
      for(var hub in hubs!){
        for(var device in hub.devices){
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
      }
      notifyListeners();
    }
  }
}