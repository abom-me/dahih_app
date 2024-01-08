
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../auto_local/lang.dart';
import '../models/tasks_model.dart';
import '../settings/sizes.dart';


class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({super.key, required this.task, required this.remainingTime});
  final Tasks task;
  final Map<String, dynamic> remainingTime;

  @override
  ConsumerState createState() => _TaskCardState();
}

class _TaskCardState extends ConsumerState<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final remainingTime = widget.remainingTime;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: Sizes.width(context),
      height: 120,
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            //     ? CrossAxisAlignment.start
            //     : CrossAxisAlignment.end,
            children: [
              Text(
                task.category!,
                // textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                task.task!,
                // textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                DateFormat("dd/MM/yy - hh:mm a")
                    .format(DateTime.parse(task.date!))
                    .replaceAll("AM",
                    Lang.get(context, key: LangKey.am))
                    .replaceAll("PM",
                    Lang.get(context, key: LangKey.pm)),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary),
              ),
            ],
          ),
          Stack(
            children: [
              Container(

                // margin: const EdgeInsets.only(left: 20),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context)
                          .colorScheme
                          .background,
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary,
                          width: 0.1)),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        Lang.get(context,
                            key: LangKey.remaining),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            remainingTime['time'].toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            Lang.get(context,
                                key: remainingTime['unit']),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary),
                          ),
                        ],
                      ),
                    ],
                  )),
              Container(
                height: 80,
                width: 80,
                child: CircularProgressIndicator(
                  value: remainingTime['progress'],
                  strokeWidth: 2,
                  color: remainingTime['progress'] >= 1
                      ? Colors.redAccent
                      : Theme.of(context).colorScheme.primary,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
