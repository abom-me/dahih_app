import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';

import '../../../components/task_card.dart';
import '../../../components/try_again_widget.dart';
import '../../../providers/home_provider.dart';
import '../../../settings/sizes.dart';
import '../../../utils/swipe_able_widget.dart';
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
                  return snapshot.data!.isEmpty?SizedBox(
                    width: Sizes.width(context),
                    height: 200,
                    child:  Center(
                      child: Text("${Lang.get(context, key: LangKey.youDontHaveTasks)} 🤩",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                    ),
                  ):ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      SwipeAbleController controller = SwipeAbleController();

                      final task = snapshot.data![index];
                      final remainingTime = ref
                          .read(homeProvider)
                          .countTaskTimeLeft(DateTime.parse(task.date!));
                      return TaskCard(
                        controller: controller,
                        task: task,
                        remainingTime: remainingTime,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return tryAgainWidget(context,onPressed: () {
                    ref.read(homeProvider).getTodayCourses();
                  });
                } else {
                  return const CourseCardShimmer();
                }
              })
        ],
      ),
    );
  }
}

