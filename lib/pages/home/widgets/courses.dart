import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';

import '../../../components/try_again_widget.dart';
import '../../../models/course_model.dart';
import '../../../providers/home_provider.dart';
import '../../../repo/courses.dart';
import '../../../settings/sizes.dart';
import '../../../utils/enum/course_status_enum.dart';
import 'courses_loading.dart';

class TodayCourses extends ConsumerStatefulWidget {
  const TodayCourses({super.key});

  @override
  ConsumerState createState() => _TodayCoursesState();
}

class _TodayCoursesState extends ConsumerState<TodayCourses> {
  ScrollController _scrollController = ScrollController();

  scrollToActiveCourse(int index){
    final activeCourseIndex = index;
    _scrollController.animateTo(
      activeCourseIndex * 300.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    }
  @override
  Widget build(BuildContext context) {
    return    Container(

      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("محاضراتك اليوم:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          const SizedBox(height: 15,),
          SizedBox(
            width: Sizes.width(context),
            height: 200,
            child: FutureBuilder(
                future: ref.read(homeProvider).getTodayCourses(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){
                    return snapshot.data!.isNotEmpty ?ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,

                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Course course = courses[index];
                        CourseStatusEnum isActive= ref.watch(homeProvider).isCourseInProgress(course.from!, course.to!);
                        final colorbg=isActive==CourseStatusEnum.inProgress?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background;
                        final textColor= isActive==CourseStatusEnum.inProgress?Theme.of(context).colorScheme.background:Color(0xff002055);
                        if(isActive==CourseStatusEnum.inProgress)   scrollToActiveCourse(index);

                        return Container(
                            width: 300,
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colorbg,
                                border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1)
                            ),
                            margin: const EdgeInsets.only(left: 10,top: 10),
                            child: Column(
                              crossAxisAlignment: course.name.toString().isArabic?CrossAxisAlignment.start:CrossAxisAlignment.end,
                              children: [

                                Text(course.name!,textAlign: TextAlign.left,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: textColor),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: course.name.toString().isArabic?MainAxisAlignment.start:MainAxisAlignment.end,
                                          children: [
                                            Icon(FluentIcons.home_person_20_filled,color: textColor,size: 20,),
                                            const SizedBox(width: 10,),
                                            Text(course.room!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w100,color: textColor),),


                                          ],
                                        ),
                                        const SizedBox(height: 10,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: course.name.toString().isArabic?MainAxisAlignment.start:MainAxisAlignment.end,
                                          children: [
                                            Icon(FluentIcons.person_20_filled,color: textColor,size: 20,),

                                            const SizedBox(width: 10,),
                                            Text(course.teacher!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w100,color: textColor),),

                                          ],
                                        ),

                                      ],),

                                    isActive==CourseStatusEnum.inProgress?StreamBuilder<int>(
                                        stream: ref.watch(homeProvider).getCourseTimeLeft(course.to!),
                                        builder: (context, snapshot) {
                                          return Column(
                                            children: [
                                              Text("الوقت المتبقي",style: TextStyle(color: textColor,fontSize: 17,fontWeight: FontWeight.w500),),
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Text(snapshot.data.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800),),
                                                  Text(" دقيقة",style: TextStyle(color: textColor,fontSize: 17,fontWeight: FontWeight.w500),),

                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                    ):isActive==CourseStatusEnum.finished?Container(


                                      child: Text("منتهية 🥳"),
                                    ):Container(


                                      child: Text("لم تبدأ بعد🥶"),
                                    )

                                  ],
                                ),
                                const SizedBox(height: 10,),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(DateFormat('hh:mm').format(course.from!),style: TextStyle(color: textColor),),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: LinearProgressIndicator(

                                        color: Theme.of(context).colorScheme.secondary,
                                        minHeight: 10,
                                        borderRadius: BorderRadius.circular(15),
                                        value: ref.watch(homeProvider).getCourseProgress(course.from!, course.to!),
                                      ),
                                    ),
                                    const SizedBox(width: 15,),

                                    Text(DateFormat('hh:mm').format(course.to!),style: TextStyle(color: textColor),),

                                  ],
                                ),
                              ],
                            )
                        );
                      },
                    ):Container(
                      width: Sizes.width(context),
                      height: 200,
                      child: const Center(
                        child: Text("لا يوجد محاضرات اليوم 🥳",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                      ),
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
          )
        ],
      ),
    );
  }
}
