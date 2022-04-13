import 'dart:io';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_noti_test/main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('notification')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text('increase'),
            ),
          ),
          Text('$counter'),
          ElevatedButton(onPressed: () {}, child: null),
          Center(
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

              // await flutterLocalNotificationsPlugin.show(
              //   0,
              //   'plain title',
              //   'plain body',
              //   detail,
              // );
              // 타임존 셋팅 필요
              final now = tz.TZDateTime.now(tz.local);
              var notiDay = now.day;

              // 예외처리

              await notification.zonedSchedule(
                1,
                '희선이 약 먹자 !!',
                '희선아 피임약 챙겨먹어!!',
                tz.TZDateTime(
                  tz.local,
                  now.year,
                  now.month,
                  now.day,
                  now.hour,
                  // now.minute + 1,
                ),
                detail,
                androidAllowWhileIdle: true,
                uiLocalNotificationDateInterpretation:
                    UILocalNotificationDateInterpretation.absoluteTime,
                matchDateTimeComponents: DateTimeComponents.time,
              );
            },
            child: const Text('add alram'),
          )),
        ],
      ),
    );
  }
}
