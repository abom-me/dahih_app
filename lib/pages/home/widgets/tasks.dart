import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';

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
    return   Container(
      child:   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("مهامك :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 15,),
          FutureBuilder(future:ref.read(homeProvider).getTasks() ,

              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,

                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {

                      final task = snapshot.data![index];
final remainingTime = ref.read(homeProvider).countTaskTimeLeft(task.date!);
                      return Container(
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
                                SizedBox(height: 5,),
                                Text(task.task!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
                                SizedBox(height: 5,),

                                Text(DateFormat("dd/MM/yy - hh:mm a").format(task.date!).replaceAll("AM", "صباحًا").replaceAll("PM", "مساءًا"),textAlign: TextAlign.left,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
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
                      );
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

          )
        ],
      ),
    );
  }
}
