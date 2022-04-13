import 'dart:io';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_noti_test/main.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('notification')),
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          final notification = FlutterLocalNotificationsPlugin();
          const android = AndroidNotificationDetails(
            '0',
            'alram test',
            channelDescription: 'alram test body',
            importance: Importance.max,
            priority: Priority.max,
          );
          const ios = IOSNotificationDetails();
          const detail = NotificationDetails(
            android: android,
            iOS: ios,
          );

          final permission = Platform.isAndroid
              ? true
              : ((await notification
                      .resolvePlatformSpecificImplementation<
                          IOSFlutterLocalNotificationsPlugin>()
                      ?.requestPermissions(
                          alert: true, badge: true, sound: true)) ??
                  false);
          if (!permission) {
            return;
          }

          await flutterLocalNotificationsPlugin.show(
            0,
            'plain title',
            'plain body',
            detail,
          );
        },
        child: const Text('add alram'),
      )),
    );
  }
}
