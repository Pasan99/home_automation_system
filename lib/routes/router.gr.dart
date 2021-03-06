// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/cupertino.dart' as _i8;

import '../models/device_model.dart' as _i9;
import '../pages/add_hub_page.dart' as _i6;
import '../pages/devices_page.dart' as _i5;
import '../pages/home_page.dart' as _i3;
import '../pages/login_page.dart' as _i4;
import '../pages/splash_screen.dart' as _i2;
import '../pages/usage_chart_page.dart' as _i7;

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
    },
    DevicesPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<DevicesPageRouteArgs>();
      return _i1.MaterialPageX(
          entry: entry,
          child: _i5.DevicesPage(key: args.key, hubId: args.hubId));
    },
    AddHubPageRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: const _i6.AddHubPage());
    },
    UsageChartPageRoute.name: (entry) {
      var args = entry.routeData.argsAs<UsageChartPageRouteArgs>();
      return _i1.MaterialPageX(
          entry: entry,
          child:
              _i7.UsageChartPage(key: args.key, deviceModel: args.deviceModel));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: ''),
        _i1.RouteConfig(HomePageRoute.name, path: '/home'),
        _i1.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i1.RouteConfig(DevicesPageRoute.name, path: '/devices/:id'),
        _i1.RouteConfig(AddHubPageRoute.name, path: '/addNewHub'),
        _i1.RouteConfig(UsageChartPageRoute.name, path: '/usageChart')
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

class DevicesPageRoute extends _i1.PageRouteInfo<DevicesPageRouteArgs> {
  DevicesPageRoute({_i8.Key? key, required String hubId})
      : super(name,
            path: '/devices/:id',
            args: DevicesPageRouteArgs(key: key, hubId: hubId));

  static const String name = 'DevicesPageRoute';
}

class DevicesPageRouteArgs {
  const DevicesPageRouteArgs({this.key, required this.hubId});

  final _i8.Key? key;

  final String hubId;
}

class AddHubPageRoute extends _i1.PageRouteInfo {
  const AddHubPageRoute() : super(name, path: '/addNewHub');

  static const String name = 'AddHubPageRoute';
}

class UsageChartPageRoute extends _i1.PageRouteInfo<UsageChartPageRouteArgs> {
  UsageChartPageRoute({_i8.Key? key, required _i9.DeviceModel deviceModel})
      : super(name,
            path: '/usageChart',
            args: UsageChartPageRouteArgs(key: key, deviceModel: deviceModel));

  static const String name = 'UsageChartPageRoute';
}

class UsageChartPageRouteArgs {
  const UsageChartPageRouteArgs({this.key, required this.deviceModel});

  final _i8.Key? key;

  final _i9.DeviceModel deviceModel;
}
