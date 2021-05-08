import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_automation_system/routes/router.gr.dart';
import 'package:home_automation_system/values/colors.dart';

final _appRouter = NewRouter();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vehicle Statics',
      theme: ThemeData(
        primaryColor: AppColors.MAIN_COLOR,
        primaryColorLight: AppColors.LIGHT_MAIN_COLOR,
        splashColor: AppColors.LIGHT_MAIN_COLOR,
        accentColor: AppColors.LIGHT_MAIN_COLOR,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.black.withOpacity(0)),
      ),
      routerDelegate: _appRouter.delegate(
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
