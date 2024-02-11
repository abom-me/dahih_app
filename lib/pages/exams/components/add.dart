import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:khlfan_shtain/models/exam_model.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/utils/keyboard_action.dart';
import 'package:uuid/uuid.dart';

import '../../../auto_local/lang.dart';
import '../../../components/buttons.dart';
import '../../../components/fullscreen_field.dart';
import '../../../components/text_field.dart';
import '../../../providers/exams_provider.dart';
import '../../../settings/sizes.dart';


class AddExam extends ConsumerStatefulWidget {
  const AddExam({super.key});

  @override
  ConsumerState createState() => _AddExamState();
}

class _AddExamState extends ConsumerState<AddExam> {

  TextEditingController examName = TextEditingController();
  TextEditingController examDetails = TextEditingController();
  TextEditingController examDate = TextEditingController();
  TextEditingController examTime = TextEditingController();
  TextEditingController examRoom = TextEditingController();
  TextEditingController examDuration = TextEditingController();
  FocusNode examNameFocus = FocusNode();
  FocusNode examDetailsFocus = FocusNode();
  FocusNode examDateFocus = FocusNode();
  FocusNode examTimeFocus = FocusNode();
  FocusNode examRoomFocus = FocusNode();
  FocusNode examDurationFocus = FocusNode();
  DateTime? date;
  TimeOfDay? time;
   final GlobalKey<FormState> _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: KeyboardActions(
        tapOutsideBehavior: TapOutsideBehavior.translucentDismiss,

        config: buildConfig(context, [examNameFocus, examDetailsFocus, examDateFocus, examTimeFocus, examRoomFocus, examDurationFocus]),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),

          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Lang.get(context, key: LangKey.examName),
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
                        return "${Lang.get(context, key: LangKey.fieldRequired)} 😶";
                      }else{
                        return null;
                      }
                    },
                    controller: examName,
                    focusNode: examNameFocus,
                    hint:  Lang.get(context, key: LangKey.examName),
                    keyboardType: TextInputType.text,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${ Lang.get(context, key: LangKey.examDetails)} (${ Lang.get(context, key: LangKey.optional)})",
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
                      GoPageAnimated.push(page: FullScreenFieldWidget(title: Lang.get(context, key: LangKey.examDetails), onDone: (String value){
                        examDetails.text=value;
                      },oldText: examDetails.text,), context: context);
                    },
                    readOnly: true,

                    controller: examDetails,
                    focusNode: examDetailsFocus,
                    hint:  Lang.get(context, key: LangKey.examDetails),
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
                              Lang.get(context, key: LangKey.examDate),
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
                                if(value!.isEmpty || date==null){
                                  return "${Lang.get(context, key: LangKey.fieldRequired)} 😶";                              }else{
                                  return null;
                                }
                              },
                              onTap: (){

                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                  initialEntryMode: DatePickerEntryMode.calendar,
                                ).then((value) {
                                  if(value != null) {
                                    examDate.text = DateFormat("dd/MM/yyyy").format(value);
                                    date = value;
                                  }
                                });
                              },
                              controller: examDate,
                              focusNode: examDateFocus,
                              readOnly: true,
                              hint:  Lang.get(context, key: LangKey.examDate),
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
                              Lang.get(context, key: LangKey.time),
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
                                if(value!.isEmpty || date==null){
                                  return "${Lang.get(context, key: LangKey.fieldRequired)} 😶";                              }else{
                                  return null;
                                }
                              },
                              onTap: (){
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  if (value != null) {
                                    examTime.text = value.format(context);
                                    time = value;
                                  }
                                });


                              },
                              controller: examTime,
                              focusNode: examTimeFocus,
                              readOnly: true,
                              hint: Lang.get(context, key: LangKey.examTime),
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
                              Lang.get(context, key: LangKey.examDuration),
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
                                if(value!.isEmpty ){
                                  return "${Lang.get(context, key: LangKey.fieldRequired)} 😶";
                                }else{
                                  return null;
                                }
                              },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              controller: examDuration,
                              focusNode: examDurationFocus,
                              // readOnly: true,
                              hint:  Lang.get(context, key: LangKey.examDuration),
                              keyboardType: TextInputType.number,
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
                              Lang.get(context, key: LangKey.examRoom),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFieldWidget(

                              controller: examRoom,
                              focusNode: examRoomFocus,
        valid: (value){
                                if(value!.isEmpty ){
                                  return "${Lang.get(context, key: LangKey.fieldRequired)} 😶";
                                }else{
                                  return null;
                                }
                              },
                              hint: Lang.get(context, key: LangKey.examRoom),
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),



                  MainButton(text:  Lang.get(context, key: LangKey.add), width: Sizes.width(context), height: 60, onPressed: (){
                    if(_form.currentState!.validate()){

                      DateTime? dateTime=  time !=null?  date?.add(Duration(hours: time!.hour,minutes: time!.minute)):date;
                      final  examID= const Uuid().v4();

        final exam =Exams(examName: examName.text, examID:examID , examDate: dateTime!, examTime: time!.format(context), examRoom: examRoom.text, examDuration: examDuration.text,examDetails: examDetails.text);
                      ref.read(examsProvider.notifier).addExam(context, exam: exam);


                    }else{

                    }

                  })
                ],
              )),
        ),
      ),
    );
  }
}
