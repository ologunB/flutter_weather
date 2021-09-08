import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'core/routes/router.dart';
import 'core/storage/local_storage.dart';
import 'core/utils/dialog_manager.dart';
import 'core/utils/dialog_service.dart';
import 'core/utils/navigator.dart';
import 'locator.dart';
import 'views/onboarding/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('.config');
  await AppCache.init(); //Initialize Hive for Flutter
  setupLocator();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details, forceReport: true);
  };
  runApp(ChrchApp());
}

class ChrchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IntaChurch',
        //  theme: lightThemeData,
        theme: ThemeData(
          textTheme: GoogleFonts.overpassTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashView(),
        builder: (BuildContext context, Widget child) => Navigator(
          key: locator<DialogService>().dialogNavigationKey,
          onGenerateRoute: (RouteSettings settings) =>
              MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => DialogManager(child: child),
          ),
        ),
        navigatorKey: locator<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
