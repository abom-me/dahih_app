import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/models/tasks_model.dart';
import 'package:uuid/uuid.dart';

import '../../../auto_local/lang.dart';
import '../../../providers/tasks_provider.dart';
import '../../../settings/sizes.dart';
import '../../tasks/components/categorys.dart';

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
  TextEditingController category= TextEditingController();
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
                  Lang.get(context, key: LangKey.taskName),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
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
                  controller: taskName,
                  focusNode: taskNameFocus,
                  hint:  Lang.get(context, key: LangKey.taskName),
                  keyboardType: TextInputType.text,
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  "${ Lang.get(context, key: LangKey.taskDetails)} (${ Lang.get(context, key: LangKey.optional)})",
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
                  hint:  Lang.get(context, key: LangKey.taskDetails),
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
            Lang.get(context, key: LangKey.taskExpirationDate),
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary),
          ),
          SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            valid: (value){
              if(value!.isEmpty || date==null){
                return Lang.get(context, key: LangKey.taskNameRequired);
              }else{
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
      taskDate.text = DateFormat("dd/MM/yyyy").format(value!);
      date = value;
    }
  });
},
            controller: taskDate,
            focusNode: FocusNode(),
            readOnly: true,
            hint:  Lang.get(context, key: LangKey.taskExpirationDate),
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
            "${Lang.get(context, key: LangKey.time)} (${Lang.get(context, key: LangKey.optional)})",
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
    if (value != null) {
      taskTime.text = value!.format(context);
      time = value;
    }
  });


},
            controller: taskTime,
            focusNode: FocusNode(),
            readOnly: true,
            hint: Lang.get(context, key: LangKey.taskCompletionTime),
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
                  Lang.get(context, key: LangKey.category),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  valid: (value){
                    if(value!.isEmpty){
                      return Lang.get(context, key: LangKey.categoryRequired);
                    }else{
                      return null;
                    }
                  },
onTap: (){

  bottomSheetBlur(context, widget:Categories(onSelectedCategory: (String selectedCategory) {
    category.text=selectedCategory;
  },), height: 500, color: Theme.of(context).colorScheme.background);
},
                  controller: category,
                  focusNode: FocusNode(),
                  readOnly: true,
                  hint:  Lang.get(context, key: LangKey.category),
                  keyboardType: TextInputType.multiline,
                ),

                MainButton(text:  Lang.get(context, key: LangKey.add), width: Sizes.width(context), height: 60, onPressed: (){
                if(_form.currentState!.validate()){

                  DateTime? dateTime=  time !=null?  date?.add(Duration(hours: time!.hour,minutes: time!.minute)):date;
                  final  taskId= const Uuid().v4();
                  Tasks task= Tasks(
                    id: taskId,
                    task: taskName.text,
                    description: taskDetails.text,
                    date: dateTime.toString(),
                    status: "inProgress",
                    // duration: 0,
                    category: category.text,
                  );
                  ref.read(tasksProvider.notifier).addTask(context, task);

                }else{

                }

                })
              ],
            )),
      ),
    );
  }
}
