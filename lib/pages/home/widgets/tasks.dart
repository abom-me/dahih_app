import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';

import '../../../components/task_card.dart';
import '../../../components/try_again_widget.dart';
import '../../../providers/home_provider.dart';
import '../../../settings/sizes.dart';
import 'courses_loading.dart';

class HomeTasks extends ConsumerStatefulWidget {
  const HomeTasks({super.key});

  @override
  ConsumerState createState() => _HomeTasksState();
}

class _HomeTasksState extends ConsumerState<HomeTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Lang.get(context, key: LangKey.yourTasks),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          FutureBuilder(
              future: ref.read(homeProvider).getTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final task = snapshot.data![index];
                      final remainingTime = ref
                          .read(homeProvider)
                          .countTaskTimeLeft(DateTime.parse(task.date!));
                      return TaskCard(
                        task: task,
                        remainingTime: remainingTime,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return tryAgainWidget(onPressed: () {
                    ref.read(homeProvider).getTodayCourses();
                  });
                } else {
                  return CourseCardShimmer();
                }
              })
        ],
      ),
    );
  }
}

