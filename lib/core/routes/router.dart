import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:mms_app/views/home/home_view.dart';

const String OnboardingScreen = '/onboarding-view';
const String HomeScreen = '/home-view';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    case HomeScreen:
      return _getPageRoute(
        routeName: settings.name,
        view: HomeView(),
        args: settings.arguments,
      );

    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute({String routeName, Widget view, Object args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view);
}

void routeTo(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.push<void>(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void routeToReplace(BuildContext context, Widget view) {
  Navigator.pushAndRemoveUntil<void>(
      context,
      CupertinoPageRoute<dynamic>(builder: (BuildContext context) => view),
      (Route<void> route) => false);
}
