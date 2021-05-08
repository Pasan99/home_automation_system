import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/models/hub_model.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/utilities/user_helper.dart';

class HubViewModel extends ChangeNotifier{
  List<HubModel>? hubs;

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
  }
}