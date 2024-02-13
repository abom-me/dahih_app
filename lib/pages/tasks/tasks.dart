import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/task_card.dart';
import 'package:khlfan_shtain/providers/tasks_provider.dart';
import 'package:khlfan_shtain/settings/sizes.dart';
import 'package:khlfan_shtain/utils/calander.dart';
import 'package:khlfan_shtain/utils/month_to_arabic.dart';

import '../../components/try_again_widget.dart';
import '../../providers/home_provider.dart';
import '../../utils/enum/task_status_enum.dart';
import '../../utils/swipe_able_widget.dart';
import '../home/widgets/courses_loading.dart';


class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  List<String>tasksDates=[];
  getTasks() async {

     await ref.read(tasksProvider).getTodayTasks();

  }
  @override
  void initState() {
    getTasks();
    // TODO: implement initState
    super.initState();
  }
  bool calender=true;
  @override
  Widget build(BuildContext context) {
   TaskStatusEnum status= ref.watch(tasksProvider).getSelectedStatus();
    return  Scaffold(

      appBar: AppBar(
        title:  Text(Lang.get(context, key: LangKey.tasks,),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${DateFormat("dd").format(DateTime.now())} ، ${Lang.get(context, key: DateFormat("MMMM").format(DateTime.now()).toMonthLangKey)} ✍️",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                     GestureDetector(onTap: (){
                        setState(() {
                          calender=!calender;
                        });
                      },child:  calender? Icon(FluentIcons.column_triple_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,):Icon(FluentIcons.calendar_rtl_12_regular,color: Theme.of(context).colorScheme.primary,size: 30,))
                    ],
                  ),
                  const SizedBox(height: 5,),
                  // Text("5 مهام عندك اليوم",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primary),),
                ],
              ),
            ),
            if(calender)...{
            SizedBox(
              height: 150,
              width: Sizes.width(context),
              child:   HorizontalCalendar(
                  dotEventsColor: Theme.of(context).colorScheme.primary,
events: ref.watch(tasksProvider).tasksDates(),
                onSelected: (a,s,v){

                  ref.read(tasksProvider.notifier).changeSelectedDate(v);
                  setState(() {
                    tasksDates=ref.read(tasksProvider).tasksDates();
                  });
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

              child:   FutureBuilder(
                  future:ref.read(tasksProvider).getSelectedTasks() ,

                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,

                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          SwipeAbleController controller = SwipeAbleController();

                          final task = snapshot.data![index];
                          final remainingTime = ref.watch(homeProvider).countTaskTimeLeft(DateTime.parse(task.date!));
                          return TaskCard(controller: controller,task: task, remainingTime: remainingTime);
                        },
                      );
                    }else if(snapshot.hasError){
                      return tryAgainWidget(context,onPressed: (){
                        ref.read(homeProvider).getTodayCourses();
                      });
                    }else{
                      return const CourseCardShimmer();
                    }
                  }

              ),
            ),}else...{
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
statBtn(title: Lang.get(context, key: LangKey.inProgress), currentStatus: TaskStatusEnum.inProgress),
statBtn(title: Lang.get(context, key: LangKey.completed), currentStatus: TaskStatusEnum.completed),
statBtn(title: Lang.get(context, key: LangKey.all), currentStatus: TaskStatusEnum.all),
                ],
              ),
              const SizedBox(height: 10,),
              Expanded(

                child:   FutureBuilder(
                    future:ref.read(tasksProvider).getTasksByType(status) ,

                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,

                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            SwipeAbleController controller = SwipeAbleController();
                            final task = snapshot.data![index];
                            final remainingTime = ref.read(homeProvider).countTaskTimeLeft(DateTime.parse(task.date!));
                            return TaskCard(
                                controller: controller,
                                task: task,
                                remainingTime: remainingTime
                            );
                          },
                        );
                      }else if(snapshot.hasError){
                        return tryAgainWidget(context,onPressed: (){
                          ref.read(homeProvider).getTodayCourses();
                        });
                      }else{
                        return const CourseCardShimmer();
                      }
                    }

                ),
              ),
            }
          ],
        ),
      ),
    ) ;
  }
 Widget statBtn({required String title,required TaskStatusEnum currentStatus}){
    TaskStatusEnum status= ref.watch(tasksProvider).getSelectedStatus();
    return  Expanded(
      child: GestureDetector(
        onTap: (){
          ref.read(tasksProvider.notifier).changeSelectedStatus(currentStatus);
        },
        child: AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 5),
          duration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          // width: 150,
          height: 50,
          decoration: BoxDecoration(
            border:status==currentStatus? Border.all(color: Theme.of(context).colorScheme.primary):null,
            boxShadow: [
              if(status !=currentStatus)  BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:status==currentStatus? Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary),),
        ),
      ),
    );
 }
}
