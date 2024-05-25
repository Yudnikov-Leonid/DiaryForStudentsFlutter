import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebasePushNotifications {
  final _fm = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'diary_channel_id', 'Notifications',
      description: 'This channel for my amazing messages :)',
      importance: Importance.defaultImportance);

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future initPushNotifications() async {
    await _fm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  _androidChannel.id, _androidChannel.name,
                  channelDescription: _androidChannel.description,
                  icon: '@drawable/notification_icon')),
          payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android =
        AndroidInitializationSettings('@drawable/notification_icon');
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _fm.requestPermission();
    initPushNotifications();
    initLocalNotifications();
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {}
