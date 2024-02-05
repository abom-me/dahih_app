import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/axction_card.dart';
import 'package:khlfan_shtain/models/exam_model.dart';

import '../../../providers/exams_provider.dart';
import '../../../utils/swipe_able_widget.dart';

class ExamCard extends ConsumerStatefulWidget {
  const ExamCard({super.key,required this.exam});
// final String examName;
  final Exams exam;
  @override
  ConsumerState createState() => _ExamCardState();
}

class _ExamCardState extends ConsumerState<ExamCard> {
  SwipeAbleController controller = SwipeAbleController();
 String fromToTime(DateTime time, String duration){
   final timeFormat = DateFormat("hh:mm a");
   final startTime = timeFormat.format(time);
   final endTime = timeFormat.format(time.add(Duration(minutes: int.parse(duration))));
   return "${startTime.replaceAll("AM", Lang.get(context, key: LangKey.am)).replaceAll("PM", Lang.get(context, key: LangKey.pm))} - ${endTime.replaceAll("AM", Lang.get(context, key: LangKey.am)).replaceAll("PM", Lang.get(context, key: LangKey.pm))}";

  }
  @override
  Widget build(BuildContext context) {
  final exam = widget.exam;

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 15),

          child: Text(DateFormat("dd/MM/yyyy").format(exam.examDate),style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 20),)
        ),
        SwipeableWidget(
          controller: controller, onDismissed: (s){}, actionExtentRatio:0.5,
          actions: [
            actionButton(context, onTap: (){}, icon: Icons.edit),
            const SizedBox(width: 10,),
            actionButton(context, onTap: (){
              ref.read(examsProvider.notifier).deleteExam(context, id: exam.examID);
              controller.close();
            }, icon: Icons.delete),

          ],
          child: Container(
            height: 150,
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(FluentIcons.book_open_16_filled,color: Theme.of(context).colorScheme.primary,size: 30,),
                    const SizedBox(width: 10,),
                    Text(exam.examName,style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 20),),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(FluentIcons.calendar_rtl_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                        const SizedBox(width: 10,),
                        Text(DateFormat("dd/M/yy").format(exam.examDate),style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(FluentIcons.home_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                        const SizedBox(width: 10,),
                        Text(exam.examRoom,style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),

                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(FluentIcons.clock_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                        const SizedBox(width: 10,),
                        Text(fromToTime(exam.examDate,exam.examDuration),style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(FluentIcons.timer_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                        const SizedBox(width: 10,),
                        Text(exam.examDuration,style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500,fontSize: 17),),
                      ],
                    ),

                  ],
                ),

              ],
            ),
          ),),
      ],
    );
  }
}
