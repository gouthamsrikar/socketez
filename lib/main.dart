import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tezos/src/screens/home_screen_handler.dart';

import 'routes.dart';
import 'src/services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tezos',
          initialRoute: Routes.HOMESCREEN,
          navigatorKey: NavigationService.navigatorKey,
          navigatorObservers:  [],
          routes: {
            Routes.HOMESCREEN: (context) =>  HomeScreenHandler(),
          },
        );
      },
    );
  }
}
