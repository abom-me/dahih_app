import 'dart:math';

import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../auto_local/lang.dart';
import '../../components/public_data.dart';

class NotificationConfig{
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
        // your call back to the UI
      },
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future<String> getTimeZone() async {
    // Use the intl package to get the current time zone
    String timeZoneName = await Future<String>(() async {
      var now = DateTime.now();
      final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();

      DateTime dateTime = DateTime.now();
      print(dateTime.timeZoneName);
      print(currentTimeZone);
      // String timeZoneOffset = timeFormat.format(now);
      return "timeZoneOffset";
    });

    return "timeZoneId";
  }

  Future<void> showNotification({required String title,required String body,required int id}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel_id',
        'Channel_name',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
    icon: '@mipmap/ic_launcher',
    largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      channelShowBadge: true,

    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        platformChannelSpecifics,

        payload: 'item x');
  }


  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required int id,
    required DateTime scheduledDate,
    required Day day,
  }) async {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'Channel_id',
    //   'Channel_name',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   showWhen: false,
    //   icon: '@mipmap/ic_launcher',
    //   largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    //   channelShowBadge: true,
    // );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    //
    // tz.Location location = tz.getLocation(currentTimeZone);
    // var now = tz.TZDateTime.now(tz.local);
    // var scheduledDateTz = tz.TZDateTime(location, scheduledDate.year, scheduledDate.month, scheduledDate.day,
    //     scheduledDate.hour, scheduledDate.minute);
    //
    // var notificationTime = scheduledDateTz.subtract(const Duration(minutes: 30));
    //
    // while (notificationTime.weekday == day.index) {
    //   notificationTime = notificationTime.add(const Duration(days: 1));
    //
    //   // Check if notificationTime is outside valid range
    //   if (notificationTime.isAfter(now.add(const Duration(days: 365)))) {
    //     // Avoid infinite loop; stop if the date is too far in the future
    //     break;
    //   }
    // }
    //
    // // Check if notificationTime is within a valid range
    // if (notificationTime.isAfter(now)) {
    //   await flutterLocalNotificationsPlugin.zonedSchedule(
    //     id,
    //     title,
    //     body,
    //     notificationTime,
    //     platformChannelSpecifics,
    //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
    //     matchDateTimeComponents: DateTimeComponents.time,
    //     payload: {"time":notificationTime}.toString(),
    //   );
    // }
  }


  Future<void> scheduleNotification2() async {
    // const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'Channel_id',
    //   'Channel_name',
    //   importance: Importance.max,
    //   priority: Priority.high,
    //   showWhen: false,
    //   icon: '@mipmap/ic_launcher',
    //   largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    //   channelShowBadge: true,
    // );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // var now = DateTime.now();
    // var notificationTime = tz.TZDateTime.from(now.add(const Duration(seconds: 5)), tz.local);
    //
    //
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   22,
    //   "2",
    //   "2",
    //
    //   notificationTime,
    //
    //   platformChannelSpecifics,
    //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.dateAndTime,
    //
    //   androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    //   payload: notificationTime.toString(),
    //
    // );
  }



  getScheduledNotification() async {
    flutterLocalNotificationsPlugin.pendingNotificationRequests().then((value) {
      for (var element in value) {
        print("------");
        print("title:${element.title}");
        print("body:${element.body}");
        print("date:${element.payload}");
        print("------");
        // print(element.channelId);
        // print(element.);

        // print(element.scheduledDate);
      }
    });
  }

  deleteAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


  Future<void> repeatNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Channel_id',
      'Channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      channelShowBadge: true,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Repeating Test Title',
      'Repeating Test Body',
      RepeatInterval.daily,
      platformChannelSpecifics,
      payload: 'Test Payload',
    );
  }
  Future<void> scheduleRandomNotification(context) async {


    // Get a random text
    String randomText = dayMsgs[Random().nextInt(dayMsgs.length)][Locales.lang];
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Channel_id',
      'Channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      channelShowBadge: true,
    );
    // const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    // final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    //
    // tz.Location location = tz.getLocation(currentTimeZone);
    // final now = tz.TZDateTime.now(location);
    // final tomorrow = DateTime(now.year, now.month, now.day + 1);
    // var scheduledDateTz = tz.TZDateTime(location,tomorrow.year, tomorrow.month, tomorrow.day,7);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   91437237, // Notification ID
    //   Lang.get(context, key: LangKey.goodMorining), // Title
    //   "${Lang.get(context, key: LangKey.dontForGet)} $randomText", // Body
    //   scheduledDateTz, // Schedule for next day
    //   platformChannelSpecifics,
    //   uiLocalNotificationDateInterpretation:
    //   UILocalNotificationDateInterpretation.absoluteTime,
    // );

  }


}