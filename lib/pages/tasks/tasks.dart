import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/task_card.dart';
import 'package:khlfan_shtain/providers/tasks_provider.dart';
import 'package:khlfan_shtain/settings/sizes.dart';
import 'package:khlfan_shtain/test.dart';
import 'package:khlfan_shtain/utils/calander.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/utils/month_to_arabic.dart';
import 'package:khlfan_shtain/utils/time_line.dart';

import '../../components/try_again_widget.dart';
import '../../providers/home_provider.dart';
import '../../repo/tasks.dart';
import '../../utils/enum/task_status_enum.dart';
import '../../utils/swipe_able_widget.dart';
import '../home/widgets/courses_loading.dart';


class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime selectedDate = DateTime.now();
    return  Scaffold(
      appBar: AppBar(
        title:  Text(Lang.get(context, key: LangKey.tasks,),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      ),
      body: Container(
        width: Sizes.width(context),
        height: Sizes.height(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
SizedBox(
  width: Sizes.width(context),
        height: 100,
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Text("${DateFormat("dd").format(DateTime.now())} ، ${Lang.get(context, key: DateFormat("MMMM").format(DateTime.now()).toMonthLangKey)} ✍️",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
  SizedBox(height: 5,),
    // Text("5 مهام عندك اليوم",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primary),),
  ],
),
),
          SizedBox(
            height: 150,
width: Sizes.width(context),
            child:   HorizontalCalendar(

              onSelected: (a,s,v){

                ref.read(tasksProvider.notifier).changeSelectedDate(v);
              },
              startDate: DateTime(2024),
                size: 50,
              years: 10,
              topDate: false,
              dateTextStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
currentDateTextStyle:               TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.background),
selectedDateColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
            Expanded(

            child:   FutureBuilder(future:ref.watch(tasksProvider).getTodayTasks() ,

                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,

                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        final task = snapshot.data![index];
                        final remainingTime = ref.read(homeProvider).countTaskTimeLeft(DateTime.parse(task.date!));
                        return SwipeableWidget(
                            actions: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.redAccent,
                                ),
                                child: const Icon(Icons.delete,color: Colors.white,),
                              ),
                              SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
ref.read(tasksProvider.notifier).changeTaskStatus(task, TaskStatusEnum.completed);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.green,
                                  ),
                                  child: Icon(Icons.done,color: Colors.white,),
                                ),
                              ),
                              SizedBox(width: 10,),

                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.deepOrange,
                                ),
                                child: Icon(Icons.edit,color: Colors.white,),
                              ),
                           ], onDismissed: (s){}, actionExtentRatio: 0.5,
                            child:  TaskCard(task: task, remainingTime: remainingTime));
                      },
                    );
                  }else if(snapshot.hasError){
                    return tryAgainWidget(onPressed: (){
                      ref.read(homeProvider).getTodayCourses();
                    });
                  }else{
                    return CourseCardShimmer();
                  }
                }

            ),
            ),
          ],
        ),
      ),
    ) ;
  }
}