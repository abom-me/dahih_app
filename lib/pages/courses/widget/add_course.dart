import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/utils/day_to_arabic.dart';
import 'package:khlfan_shtain/utils/string_to_time.dart';
import 'package:uuid/uuid.dart';

import '../../../auto_local/lang.dart';
import '../../../components/buttons.dart';
import '../../../components/text_field.dart';
import '../../../models/course_model.dart';
import '../../../providers/course_table_provider.dart';
import '../../../settings/sizes.dart';
import '../../../utils/enum/days_enum.dart';


class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState createState() => _AddCourseState();
}

class _AddCourseState extends ConsumerState<AddCourse> {

    TextEditingController courseName = TextEditingController();
    TextEditingController courseStart = TextEditingController();
    TextEditingController courseEnd = TextEditingController();
    TextEditingController teacherName = TextEditingController();
    TextEditingController roomNo= TextEditingController();
    TimeOfDay? courseEndTime;
    TimeOfDay? courseStartTime;
    List<String> days=[];
    List<String> daysOfWeek = [
     DaysEnum.sunday.name,
      DaysEnum.monday.name,
      DaysEnum.tuesday.name,
      DaysEnum.wednesday.name,
      DaysEnum.thursday.name,
      DaysEnum.friday.name,
      DaysEnum.saturday.name,
    ];
    FocusNode taskNameFocus = FocusNode();
    final GlobalKey<FormState> _form = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return Container(

        // height: 00,
        // padding: const EdgeInsets.only(bottom: 30,top: 10),
        child: SingleChildScrollView(
          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Lang.get(context, key: LangKey.courseName),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    valid: (value){
                      if(value!.isEmpty){
                        return Lang.get(context, key: LangKey.taskExdateRequired);
                      }else{
                        return null;
                      }
                    },
                    controller: courseName,
                    focusNode: taskNameFocus,
                    hint:  Lang.get(context, key: LangKey.courseName),
                    keyboardType: TextInputType.text,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Lang.get(context, key: LangKey.roomNo),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    multiLine: true,
                    controller: roomNo,
                    focusNode: FocusNode(),
                    hint:  Lang.get(context, key: LangKey.roomNo),
                    keyboardType: TextInputType.multiline,
                  ),


                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                   '${Lang.get(context, key: LangKey.teacherName)} (${Lang.get(context, key: LangKey.optional)})',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    multiLine: true,
                    controller: roomNo,
                    focusNode: FocusNode(),
                    hint:  Lang.get(context, key: LangKey.roomNo),
                    keyboardType: TextInputType.multiline,
                  ),




                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              Lang.get(context, key: LangKey.startTime),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              valid: (value){
                                if(value!.isEmpty || courseStartTime==null){
                                  return Lang.get(context, key: LangKey.taskNameRequired);
                                }else{
                                  return null;
                                }
                              },
                              onTap: (){

                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if(value != null) {
                                    courseStart.text = value.format(context);
                                    courseStartTime = value;
                                  }
                                });
                              },
                              controller: courseStart,
                              focusNode: FocusNode(),
                              readOnly: true,
                              hint:  Lang.get(context, key: LangKey.startTime),
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              Lang.get(context, key: LangKey.endTime),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: courseStartTime??TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    courseEnd.text = value.format(context);
                                    courseEndTime = value;
                                    if(courseStartTime!.hour>courseEndTime!.hour){
                                      courseEnd.text="";
                                      courseEndTime=null;
                                     Alert.msg(context, Lang.get(context, key: LangKey.error), Lang.get(context, key: LangKey.endTimeError));
                                    }
                                  }
                                });


                              },
                              controller: courseEnd,
                              focusNode: FocusNode(),
                              readOnly: true,
                              hint: Lang.get(context, key: LangKey.endTime),
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),



                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    Lang.get(context, key: LangKey.days),
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
// Select days
              Row(
                children: [
               for(final day in daysOfWeek)
                 Expanded(
                   child: GestureDetector(
                     onTap: (){
                       if(days.contains(day)){
                         days.remove(day);
                       }else{
                         days.add(day);
                       }
                       setState(() {

                       });
                     },
                     child: AnimatedContainer(
                       duration: const Duration(milliseconds: 300),
width: 40,
                        height: 40,
                       margin: const EdgeInsets.only(left: 2,right: 2),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(100),
                         color: days.contains(day)?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                       ),
                       child: Center(child: Text(Lang.get(context, key: day.dayToLangKey),style: TextStyle(fontWeight: FontWeight.w500,color: days.contains(day)?Theme.of(context).colorScheme.background:Theme.of(context).colorScheme.primary),)),
                     ),
                   ),
                  ),
                ],
              ),





                  MainButton(text:  Lang.get(context, key: LangKey.add), width: Sizes.width(context), height: 60, onPressed: (){
                    if(_form.currentState!.validate()){

                      final  courseId= const Uuid().v4();
                      final course=Course(
                        id: courseId,
                        name: courseName.text,
                        room: roomNo.text,
                        teacher: teacherName.text,
                        from: courseStartTime!.toStringTime,
                        to: courseEndTime!.toStringTime,
                        days: days,
                      );
ref.read(courseTableProvider).addCourse(context, course);
                      Navigator.pop(context);

                    }else{

                    }

                  }),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              )),
        ),
      );
    }
  }

