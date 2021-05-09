import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/utilities/user_helper.dart';
import 'package:home_automation_system/values/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this, value: 0.2);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.bounceIn);

    _controller.forward();
    Future.delayed(Duration(milliseconds: 800)).then((value) async {
      await UserHelper().getCurrentUser();
      final FirebaseAuth _auth = FirebaseAuth.instance;
      Navigator.of(context).pop();
      if (_auth.currentUser == null) {
        AutoRouter.of(context).popAndPush(
            LoginPageRoute());
      } else {
        AutoRouter.of(context).navigate(
            HomePageRoute());
      }

      // AutoRouter.of(context).navigate(HomePageRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: AppColors.MAIN_COLOR,
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ScaleTransition(
                    scale: _animation,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        // Image.asset(
                        //   "assets/images/img_intro.png",
                        //   width: MediaQuery.of(context).size.width,
                        //   height: 200,
                        // ),
                        Icon(
                          CupertinoIcons.home,
                          color: Colors.white,
                          size: 200,
                        ),
                        Container(
                          height: 20,
                        ),
                        Text(
                          "Smart Home",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.TEXT_WHITE),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text("Home Automation System", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: AppColors.TEXT_WHITE),),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32, right: 32, left: 32),
                  child: Text("Software version v1.0", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: AppColors.TEXT_WHITE),),
                )
              ],
            ),
          ),
        ));
  }
}
