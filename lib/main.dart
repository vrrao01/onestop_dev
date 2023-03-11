// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onestop_dev/functions/utility/check_last_updated.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/pages/profile.dart';
import 'package:onestop_dev/routes.dart';
import 'package:onestop_dev/stores/common_store.dart';
import 'package:onestop_dev/stores/login_store.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:onestop_dev/stores/restaurant_store.dart';
import 'package:onestop_dev/stores/timetable_store.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await checkLastUpdated();

  OneSignal.shared.setAppId("2d48b196-f49e-4e86-afaa-279f4e6e17c4");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    OSNotificationDisplayType.notification;
  });

  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
     await navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
    print('PRINTING RESULT');
    print(result);
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {});

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) {});

  OneSignal.shared.setEmailSubscriptionObserver(
      (OSEmailSubscriptionStateChanges emailChanges) {});

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;

    return MultiProvider(
      providers: [
        Provider<LoginStore>(
          create: (_) => LoginStore(),
        ),
        Provider<RestaurantStore>(
          create: (_) => RestaurantStore(),
        ),
        Provider<MapBoxStore>(
          create: (_) => MapBoxStore(),
        ),
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        )
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
            scaffoldBackgroundColor: kBackground,
            splashColor: Colors.transparent),
        title: 'OneStop 2.0',
        routes: routes,
      ),
    );
  }
}
