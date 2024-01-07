import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
        title: const Text("المهام"),
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

    Text("${DateFormat("dd").format(DateTime.now())} ، ${DateFormat("MMMM").format(DateTime.now()).toArabicMonth} ✍️",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
  SizedBox(height: 5,),
    Text("5 مهام عندك اليوم",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primary),),
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
                                child: Icon(Icons.delete,color: Colors.white,),
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
                            child:  Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          width: Sizes.width(context),
                          height: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.background,
                            border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: task.task.toString().isArabic?CrossAxisAlignment.start:CrossAxisAlignment.end,
                                children: [
                                  Text(task.category!,textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w200,color: Theme.of(context).colorScheme.secondary),),
                                  const SizedBox(height: 5,),
                                  Text(task.task!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                  const SizedBox(height: 5,),

                                  Text(DateFormat("dd/MM/yy - hh:mm a").format(DateTime.parse(task.date!)).replaceAll("AM", "صباحًا").replaceAll("PM", "مساءًا"),textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Theme.of(context).colorScheme.background,
                                          border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1)
                                      ),
                                      child:Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("المتبقي",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(remainingTime['time'].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                              SizedBox(width: 5,),
                                              Text(remainingTime['unit'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                  Container(
                                    height: 70,
                                    width: 70,
                                    child: CircularProgressIndicator(
                                      value: remainingTime['progress'],
                                      strokeWidth: 2,
                                      color: remainingTime['progress']>=1?Colors.redAccent:Theme.of(context).colorScheme.primary,
                                      backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
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