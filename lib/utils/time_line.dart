import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/sizes.dart';


class Task {
  final double startHour;
  final double endHour;
  final String title;
  final Color color;

  Task( {required this.color,required this.startHour, required this.endHour, required this.title});
}

class Timeline extends ConsumerStatefulWidget {
  const Timeline( {Key?key,required this.tasks}):super(key:key);

final List<Task> tasks;

  @override
  ConsumerState createState() => _TimelineState();
}

class _TimelineState extends  ConsumerState<Timeline> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  // Example tasks
  List<Task> tasks = [
    Task(color:const Color(0xff63B4FF),startHour: 12.0, endHour: 13.30, title: 'اسايمنت الداتابيس'),
    Task(color:const Color(0xffB1D199),startHour: 14.00, endHour: 16.00, title: 'اكمال مشروع الويب'),
    // Add more tasks here
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 300), () => _scrollToCurrentTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    final currentTime = DateTime.now();
    final scrollPosition = currentTime.hour * 80;
    _scrollController.animateTo(
      scrollPosition.toDouble(),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 24, // Total hours in a day
      controller: _scrollController,
      itemBuilder: (context, index) {
        final hour = index;
        final time = TimeOfDay(hour: hour, minute: 0);

        // Filter tasks for the current hour
        List<Task> hourTasks = tasks.where((task) => task.startHour <= hour && task.endHour > hour).toList();

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(

                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: Sizes.width(context),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Text(
                            time.format(context).replaceAll(':', '').replaceAll('0', '').replaceAll("PM", "م").replaceAll("AM", "ص"),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                    ),
                  ),
                  // Add a line between each hour except the last one
                  // if (index < 23)
                  // Divider(
                  //   height: 1,
                  //   color: Colors.grey,
                  //   thickness: 1,
                  //   indent: 20,
                  //   endIndent: 20,
                  // ),
                ],
              ),
            ),
            for (final task in hourTasks)
              Positioned(
                top: (task.startHour - hour) * 80.0,
                left: 40,
                right: 100,
                height: (task.endHour - task.startHour) * 80.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: task.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      task.title,
                      style: const TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}