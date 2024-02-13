// import 'package:timezone/browser.dart';

// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// // import 'package:flutter/material.dart';
// // import 'package:khlfan_shtain/repo/courses.dart';
// // import 'package:khlfan_shtain/utils/day_to_arabic.dart';
// // import 'package:khlfan_shtain/utils/enum/days_enum.dart';
// // import 'package:localstorage/localstorage.dart';
// //
// // class HomePage extends StatefulWidget {
// //   HomePage({Key? key}) : super(key: key);
// //
// //   @override
// //   _MyHomePageState createState() => new _MyHomePageState();
// // }
// //
// // class TodoItem {
// //   String title;
// //   bool done;
// //
// //   TodoItem({required this.title, required this.done});
// //
// //   toJSONEncodable() {
// //     Map<String, dynamic> m =  {};
// //
// //     m['title'] = title;
// //     m['done'] = done;
// //
// //     return m;
// //   }
// // }
// //
// // class TodoList {
// //   List<TodoItem> items = [];
// //
// //   toJSONEncodable() {
// //     return items.map((item) {
// //       return item.toJSONEncodable();
// //     }).toList();
// //   }
// // }
// //
// // class _MyHomePageState extends State<HomePage> {
// //   final TodoList list =  TodoList();
// //   final LocalStorage storage =  LocalStorage('todo_app.json');
// //   bool initialized = false;
// //   TextEditingController controller =  TextEditingController();
// //
// //   _toggleItem(TodoItem item) {
// //     setState(() {
// //       item.done = !item.done;
// //       _saveToStorage();
// //     });
// //   }
// //
// //   _addItem(String title) {
// //
// //     setState(() {
// //       final item = new TodoItem(title: title, done: false);
// //       list.items.add(item);
// //       _saveToStorage();
// //     });
// //   }
// //
// //   _saveToStorage() {
// //     storage.setItem('todos', list.toJSONEncodable());
// //   }
// //
// //   _clearStorage() async {
// //     await storage.clear();
// //
// //     setState(() {
// //       list.items = storage.getItem('todos') ?? [];
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return new Scaffold(
// //       appBar: new AppBar(
// //         title: new Text('Localstorage demo'),
// //       ),
// //       body: Container(
// //           padding: EdgeInsets.all(10.0),
// //           constraints: BoxConstraints.expand(),
// //           child: FutureBuilder(
// //             future: storage.watchy,
// //             builder: (BuildContext context, AsyncSnapshot snapshot) {
// //               if (snapshot.data == null) {
// //                 return Center(
// //                   child: CircularProgressIndicator(),
// //                 );
// //               }
// //
// //               if (!initialized) {
// //                 var items = storage.getItem('todos');
// //
// //                 if (items != null) {
// //                   list.items = List<TodoItem>.from(
// //                     (items as List).map(
// //                           (item) => TodoItem(
// //                         title: item['title'],
// //                         done: item['done'],
// //                       ),
// //                     ),
// //                   );
// //                 }
// //
// //                 initialized = true;
// //               }
// //
// //               List<Widget> widgets = list.items.map((item) {
// //                 return CheckboxListTile(
// //                   value: item.done,
// //                   title: Text(item.title),
// //                   selected: item.done,
// //                   onChanged: (_) {
// //                     _toggleItem(item);
// //                   },
// //                 );
// //               }).toList();
// //
// //               return Column(
// //                 children: <Widget>[
// //                   Expanded(
// //                     flex: 1,
// //                     child: ListView(
// //                       children: widgets,
// //                       itemExtent: 50.0,
// //                     ),
// //                   ),
// //                   ListTile(
// //                     title: TextField(
// //                       controller: controller,
// //                       decoration: InputDecoration(
// //                         labelText: 'What to do?',
// //                       ),
// //                       onEditingComplete: _save,
// //                     ),
// //                     trailing: Row(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: <Widget>[
// //                         IconButton(
// //                           icon: Icon(Icons.save),
// //                           onPressed: _save,
// //                           tooltip: 'Save',
// //                         ),
// //                         IconButton(
// //                           icon: Icon(Icons.delete),
// //                           onPressed: _clearStorage,
// //                           tooltip: 'Clear storage',
// //                         )
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               );
// //             },
// //           )),
// //     );
// //   }
// //
// //   void _save() {
// //     _addItem(controller.value.text);
// //     controller.clear();
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   // Example data structure to store user's timetable
//   List<Course> userTimetable = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Populate userTimetable with example data (replace this with your logic)
//     userTimetable = [
//       Course(name: 'Math', days: [DateTime.monday, DateTime.wednesday], time: Time(10, 0, 0)),
//       Course(name: 'English', days: [DateTime.tuesday, DateTime.thursday], time: Time(14, 30, 0)),
//       // Add more courses as needed
//     ];
//
//     // Schedule notifications based on the user's timetable
//     scheduleNotifications();
//   }
//
//   Future<void> scheduleNotifications() async {
//     // Cancel any existing notifications
//     await flutterLocalNotificationsPlugin.cancelAll();
//
//     // Schedule notifications based on user's timetable
//     for (var course in userTimetable) {
//       for (var day in course.days) {
//         var notificationTime = TZDateTime.now(tz.local)
//             .next(day)
//             .add(Duration(hours: course.time.hour, minutes: course.time.minute));
//
//         await flutterLocalNotificationsPlugin.zonedSchedule(
//           course.hashCode,
//           'Upcoming ${course.name} class',
//           'Time: ${course.time.format(context)}',
//           notificationTime,
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'your_channel_id',
//               'your_channel_name',
//               'your_channel_description',
//             ),
//             iOS: IOSNotificationDetails(),
//           ),
//           androidAllowWhileIdle: true,
//           uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//           matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Timetable'),
//       ),
//       body: ListView.builder(
//         itemCount: userTimetable.length,
//         itemBuilder: (context, index) {
//           var course = userTimetable[index];
//           return ListTile(
//             title: Text(course.name),
//             subtitle: Text('Days: ${course.days.map((day) => DateFormat.E().format(DateTime(2022, 1, 1, course.time.hour, course.time.minute, 0)).substring(0, 2)).join(', ')}\nTime: ${course.time.format(context)}'),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class Course {
//   final String name;
//   final List<int> days;
//   final Time time;
//
//   Course({required this.name, required this.days, required this.time});
// }
//
// extension TimeFormatting on Time {
//   String format(BuildContext context) {
//     final now = TZDateTime.now(tz.local);
//     final dateTime = TZDateTime(now.timeZone as Location, now.year, now.month, now.day, hour, minute);
//     return DateFormat.Hm(context).format(dateTime);
//   }
// }


// class PomodoroTimer extends ConsumerStatefulWidget {
//   @override
//   _PomodoroTimerState createState() => _PomodoroTimerState();
// }
//
// class _PomodoroTimerState extends ConsumerState<PomodoroTimer> {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pomodoro Timer'),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Text(
//                   '${ref.watch(promoTimerViewModelProvider).minutes}:${ref.watch(promoTimerViewModelProvider).seconds.toString().padLeft(2, '0')}',
//                   style:  TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),
//                 ),
//
//               SizedBox(
//
//                   height: Sizes.width(context) *0.8,
//                   width: Sizes.width(context) *0.8,
//
//               child:   CircularProgressIndicator(
//                 strokeWidth: 10,
//                 strokeCap: StrokeCap.round,
// backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
//                 color: Theme.of(context).colorScheme.primary,
//                 value: (ref.watch(promoTimerViewModelProvider).minutes * 60 + ref.watch(promoTimerViewModelProvider).seconds) / 1500,
//                 valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
//               ),),
//                 SizedBox(height: 20),
//
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//
//                     ref.read(promoTimerViewModelProvider.notifier).changeisRunning();
//                       if ( ref.watch(promoTimerViewModelProvider.notifier).isRunning) {
//                         ref.read(promoTimerViewModelProvider.notifier).startTimer();
//                       } else {
//                         ref.read(promoTimerViewModelProvider.notifier).pushTimer();
//                       }
//
//                   },
//                   child: Text(ref.watch(promoTimerViewModelProvider).isRunning
//                       ? 'Pause' : 'Start'),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed:(){
//
//                     ref.watch(promoTimerViewModelProvider.notifier).resetTimer();
//                     }
//                   ,
//                   child: Text('Reset'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
