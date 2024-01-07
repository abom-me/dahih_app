import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/tasks_provider.dart';
import '../../../settings/sizes.dart';

class NewTaskPage extends ConsumerStatefulWidget {
  const NewTaskPage({super.key});

  @override
  ConsumerState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends ConsumerState<NewTaskPage> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDetails = TextEditingController();
  TextEditingController taskDate = TextEditingController();
  TextEditingController taskTime = TextEditingController();
DateTime? date;
TimeOfDay? time;
  FocusNode taskNameFocus = FocusNode();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(

      // height: 00,
      // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: SingleChildScrollView(
        child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اسم المهمة",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: taskName,
                  focusNode: taskNameFocus,
                  hint: "اسم المهمة",
                  keyboardType: TextInputType.text,
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "تفاصيل المهمة (اختياري)",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  multiLine: true,
                  controller: taskDetails,
                  focusNode: FocusNode(),
                  hint: "تفاصيل المهمة",
                  keyboardType: TextInputType.multiline,
                ),
Row(
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "تاريخ انتهاء المهمة",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldWidget(
onTap: (){

  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    initialEntryMode: DatePickerEntryMode.calendar,
  ).then((value) {
    taskDate.text=value.toString();
    date=value;
  });
},
            controller: taskDate,
            focusNode: FocusNode(),
            readOnly: true,
            hint: "تاريخ انتهاء  المهمة",
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    ),
    SizedBox(
      width: 20,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "الوقت (اختياري)",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldWidget(
onTap: (){
  showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
  ).then((value) {
    taskTime.text=value.toString();
  });

},
            controller: taskTime,
            focusNode: FocusNode(),
            readOnly: true,
            hint: "وقت انتهاء  المهمة",
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    ),


  ],
),



                SizedBox(
                  height: 20,
                ),
                Text(
                  "التصنيف",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
onTap: (){

  bottomSheetBlur(context, widget: widget, height: 200, color: Colors.white);
},
                  controller: taskTime,
                  focusNode: FocusNode(),
                  readOnly: true,
                  hint: "التصنيف",
                  keyboardType: TextInputType.multiline,
                ),

                MainButton(text: "اضافة", width: Sizes.width(context), height: 60, onPressed: (){
                  //
                  // final String task;
                  // final String? description;
                  // final DateTime? date;
                  // final int? time;
                  // final int? duration;
                  // final String? status;
                  // final String? category;
                  // final String? id;
                final  taskId= const Uuid().v4();
                  Tasks task= Tasks(
                    id: taskId,
                    task: taskName.text,
                    description: taskDetails.text,
                    date: date.toString(),
                    status: "inProgress",
                    // duration: 0,
                    category: "category",
                  );
                  ref.read(tasksProvider.notifier).addTask(context, task);

                })
              ],
            )),
      ),
    );
  }
}
