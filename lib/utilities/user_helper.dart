import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_automation_system/models/user_model.dart';
import 'package:home_automation_system/routes/router.gr.dart';
class UserHelper {
  static final UserHelper _userHelper = UserHelper._internal();
  UserModel? _user;
  UserModel? _oldUser;

  factory UserHelper() {
    return _userHelper;
  }

  static bool checkLoginStats(BuildContext context,
      {bool isLoginPage = false}) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser == null) {
      if (!isLoginPage) {
        AutoRouter.of(context).popAndPush(LoginPageRoute());
      }
      return false;
    } else {
      if (isLoginPage) {
        AutoRouter.of(context).navigate(HomePageRoute());
      }
      return true;
    }
  }

  UserHelper._internal();

  Future<UserModel?> getCurrentUser() async {
    if (_user != null) {
      return _user;
    } else {
      try {
        Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
        Auth.User user = auth.currentUser!;
        FirebaseFirestore store = FirebaseFirestore.instance;
        QuerySnapshot snapshot = await store
            .collection("users")
            .where("id", isEqualTo: user.uid)
            .get();

        List<DocumentSnapshot> documents = snapshot.docs;
        if (documents.length > 0) {
          _user =
              UserModel.fromJson(documents[0].data() as Map<String, dynamic>);
        }
      } catch (Exception) {
        print(Exception.toString());
        return null;
      }
    }
    _oldUser = _user;
    return _user;
  }

  UserModel? getCachedUser() {
    return _oldUser;
  }

  logout() async {
    _user = null;
    _oldUser = null;
    await Auth.FirebaseAuth.instance.signOut();
  }

  Future<UserModel?> renewUser() async {
    _user = null;
    return await getCurrentUser();
  }

  updateUser(UserModel user) async {
    print(user.id);
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").doc(user.id).get();
    if (!snapshot.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .set(user.toJson());
    }
    await renewUser();
  }

  updateExistingUser(UserModel user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.id)
        .update(user.toJson());
    await renewUser();
  }
}
