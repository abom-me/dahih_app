import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';


class CourseDetails extends ConsumerWidget {
   CourseDetails({super.key, required this.course});
Course course;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20),
child: Column(
  textDirection: course.name.toString().isArabic?TextDirection.rtl:TextDirection.ltr,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Text(course.name!,textAlign: course.name.toString().isArabic?TextAlign.right:TextAlign.left,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),),
    SizedBox(height: 10,),
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
                Icon(FluentIcons.home_person_20_filled,size: 25,color:Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 10,),
                Text(course.room!,textAlign: TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Theme.of(context).colorScheme.secondary),),


              ],
            ),
            const SizedBox(height: 20,),

            if(course.teacher !=null && course.teacher !='')Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: course.name.toString().isArabic?MainAxisAlignment.start:MainAxisAlignment.end,
              children: [
                Icon(FluentIcons.person_20_filled,size: 25,color:Theme.of(context).colorScheme.secondary),

                const SizedBox(width: 10,),
                Text(course.teacher!,textAlign: TextAlign.left,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color:Theme.of(context).colorScheme.secondary),),

              ],
            ),

          ],),



      ],
    ),
    const SizedBox(height: 20,),

    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(FluentIcons.clock_12_filled,size: 25,color:Theme.of(context).colorScheme.secondary),
        const SizedBox(width: 10,),

        Text(course.from!,style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),),
   Text(' - ',style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),),

        Text(course.to!,style: TextStyle(fontSize: 20,color:Theme.of(context).colorScheme.secondary),),

      ],
    ),


  ],
),
    ) ;
  }
}