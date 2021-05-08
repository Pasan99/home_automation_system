import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/utilities/user_helper.dart';
import 'package:home_automation_system/values/config.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  _ProfileFragmentState createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(CupertinoIcons.person, size: 40, color: Colors.grey,),
                  )
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text(UserHelper().getCachedUser()!.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Container(height: 4,),
                      Wrap(
                        children: [
                          Text(UserHelper().getCachedUser()!.email, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(height: 24,),
          Divider(height: 1,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: OutlinedButton(
              onPressed: () async {
                await UserHelper().logout();
                AutoRouter.of(context).pop();
                AutoRouter.of(context).pop();
                AutoRouter.of(context).replace(LoginPageRoute());
              },
              style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1, color: Colors.grey),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(AppConfig.BUTTON_BORDER_RADIUS - 6))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
