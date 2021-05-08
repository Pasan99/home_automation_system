import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_automation_system/utilities/user_helper.dart';

class LoginPageViewModel extends ChangeNotifier{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Future<bool> loginUser() async {
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      await UserHelper().getCurrentUser();
      if (result.user != null){
        return true;
      }
    }
    catch(ex){
      print(ex);
    }

    return false;
  }
}