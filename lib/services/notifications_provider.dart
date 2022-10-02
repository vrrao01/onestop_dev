import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:shared_preferences/shared_preferences.dart';

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    print('notification payload: $payload');
  }
  // await Navigator.pushNamed(context, HomePage.id);
}

Future<bool> checkForNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
  String? token=sharedPreferences.getString("fcm-token");
  if(token==null){
    token=await messaging.getToken();
    sharedPreferences.setString("fcm-token", token!);
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin!
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveNotificationResponse);
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          groupKey: 'OneStop');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification!;
    AndroidNotification android = message.notification!.android!;
    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin!.show(notification.hashCode,
          notification.title, notification.body, notificationDetails);
    }
    savenotif(notification);
  });

  return true;
}
void savenotif(RemoteNotification notification) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String notif=notification.hashCode.toString()+notification.title!+notification.body!;
  List<String>? notifications = preferences.getStringList('notifications') == null
      ? []
      : preferences.getStringList('notifications');
  if (notifications!.length > 14) {
    notifications.removeAt(0);
  }
  notifications.add(notif);
  preferences.setStringList('notifications', notifications);
}