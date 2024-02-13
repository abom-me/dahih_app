import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';

import '../../../components/bottom_sheet.dart';
import '../../../components/try_again_widget.dart';
import '../../../models/course_model.dart';
import '../../../providers/home_provider.dart';
import '../../../settings/sizes.dart';
import '../../../utils/enum/course_status_enum.dart';
import '../../courses/widget/course_details.dart';
import 'courses_loading.dart';

class TodayCourses extends ConsumerStatefulWidget {
  const TodayCourses({super.key});

  @override
  ConsumerState createState() => _TodayCoursesState();
}

class _TodayCoursesState extends ConsumerState<TodayCourses> {
  final ScrollController _scrollController = ScrollController();

  scrollToActiveCourse(int index){
    final activeCourseIndex = index;
    _scrollController.animateTo(
      activeCourseIndex * 320.0,
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
           Text(Lang.get(context, key: LangKey.yourLecturesToday),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          const SizedBox(height: 15,),
          SizedBox(
            width: Sizes.width(context),
            height: 200,
            child: FutureBuilder(
                future: ref.watch(homeProvider).getTodayCourses(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                    return snapshot.data!.isNotEmpty ?ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,

                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Course course = snapshot.data![index];
                        
                        CourseStatusEnum isActive= ref.watch(homeProvider).isCourseInProgress(course.from!.toTimeOfDay, course.to!.toTimeOfDay);
                        final colorbg=isActive==CourseStatusEnum.inProgress?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background;
                        final textColor= isActive==CourseStatusEnum.inProgress?Theme.of(context).colorScheme.background:Theme.of(context).colorScheme.onBackground;
                        if(isActive==CourseStatusEnum.inProgress && snapshot.data!.length>1)   scrollToActiveCourse(index);

                        return GestureDetector(
                          onTap: (){
                            bottomSheetBlur(context, widget: CourseDetails(course: course), height: 300);
                          },
                          child: Container(
                              width: 320,
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: colorbg,
                                  border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1)
                              ),
                              margin: const EdgeInsets.only(left: 10,top: 10),
                              child: Column(
                                textDirection: course.name.toString().isArabic?TextDirection.rtl:TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(course.name!.length>15?course.name!.substring(0,15)+"...":course.name!,textAlign: course.name.toString().isArabic?TextAlign.right:TextAlign.left,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: textColor),),
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
                                              Text(course.room!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: textColor),),


                                            ],
                                          ),
                                          const SizedBox(height: 10,),

                                          if(course.teacher !=null && course.teacher !='')Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: course.name.toString().isArabic?MainAxisAlignment.start:MainAxisAlignment.end,
                                            children: [
                                              Icon(FluentIcons.person_20_filled,color: textColor,size: 20,),

                                              const SizedBox(width: 10,),
                                              Text(course.teacher!.length>15?course.teacher!.substring(0,15)+"...":course.teacher!,textAlign: TextAlign.left,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w100,color: textColor),),

                                            ],
                                          ),

                                        ],),

                                      isActive==CourseStatusEnum.inProgress?StreamBuilder<int>(
                                          stream: ref.watch(homeProvider).getCourseTimeLeft(course.to!.toTimeOfDay),
                                          builder: (context, snapshot) {
                                            return Column(
                                              children: [
                                                Text(Lang.get(context, key: LangKey.remainingTime),style: TextStyle(color: textColor,fontSize: 17,fontWeight: FontWeight.w500),),
                                                const SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Text(snapshot.data.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w800),),
                                                    Text(Lang.get(context, key: LangKey.minute),style: TextStyle(color: textColor,fontSize: 17,fontWeight: FontWeight.w500),),

                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                      ):isActive==CourseStatusEnum.finished?Container(


                                        child: Text("${Lang.get(context, key: LangKey.finished)} 🥳",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                      ):Container(


                                        child: Text("${Lang.get(context, key: LangKey.notStartedYet)}🥶",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                      )

                                    ],
                                  ),
                                  const SizedBox(height: 10,),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(course.from!,style: TextStyle(color: textColor),),
                                      const SizedBox(width: 15,),
                                      Expanded(
                                        child: LinearProgressIndicator(

                                          color: Theme.of(context).colorScheme.secondary,
                                          minHeight: 10,
                                          borderRadius: BorderRadius.circular(15),
                                          value: ref.watch(homeProvider).getCourseProgress(course.from!.toTimeOfDay, course.to!.toTimeOfDay),
                                        ),
                                      ),
                                      const SizedBox(width: 15,),

                                      Text(course.to!,style: TextStyle(color: textColor),),

                                    ],
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                    ):SizedBox(
                      width: Sizes.width(context),
                      height: 200,
                      child:  Center(
                        child: Text("${Lang.get(context, key: LangKey.noLecturesToday)} 🥳",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                      ),
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
          )
        ],
      ),
    );
  }
}
