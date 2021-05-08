
import 'package:auto_route/annotations.dart';
import 'package:home_automation_system/pages/home_page.dart';
import 'package:home_automation_system/pages/login_page.dart';
import 'package:home_automation_system/pages/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true, path: ""),
    MaterialRoute(page: HomePage, path: "/home"),
    MaterialRoute(page: LoginPage, path: "/login"),
  ],
)
class $NewRouter {
}
