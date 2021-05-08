// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../pages/home_page.dart' as _i3;
import '../pages/login_page.dart' as _i4;
import '../pages/splash_screen.dart' as _i2;

class NewRouter extends _i1.RootStackRouter {
  NewRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.SplashScreen());
    },
    HomePageRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: const _i3.HomePage());
    },
    LoginPageRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i4.LoginPage());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: ''),
        _i1.RouteConfig(HomePageRoute.name, path: '/home'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '');

  static const String name = 'SplashScreenRoute';
}

class HomePageRoute extends _i1.PageRouteInfo {
  const HomePageRoute() : super(name, path: '/home');

  static const String name = 'HomePageRoute';
}

class LoginPageRoute extends _i1.PageRouteInfo {
  const LoginPageRoute() : super(name, path: '/login');

  static const String name = 'LoginPageRoute';
}
