import 'dart:math';

import 'package:color_hex/color_hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/models/notes.dart';
import 'package:khlfan_shtain/pages/notes/component/tages.dart';
import 'package:khlfan_shtain/settings/sizes.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/viewmodel/notes_viewmodel.dart';
import 'package:uuid/uuid.dart';

import '../../../auto_local/lang.dart';
import '../../../components/bottom_sheet.dart';
import '../../../utils/keyboard_action.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key});

  @override
  ConsumerState createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  TextEditingController note=TextEditingController();
  TextEditingController emoji=TextEditingController();
  TextEditingController tags=TextEditingController();
  static const List<String>emojis=[
    '📖',
    '📝',
    '🤩',
    '🎉',
    '😆',
    '🛠',
    '✏️',
    '🥳',
    '🤔',
    '👍',
    '👨‍🎓',
    '💻'
  ];
  static const List<Map<String,dynamic>>colors=[
    {'string':0xff84b6d9
      ,'color':Color(0xff84b6d9)},
    {'string':0xff84c7bc
      ,'color':Color(0xff84c7bc)},
    {'string':0xffa4c3b2
      ,'color':Color(0xffa4c3b2)},
    {'string':0xffffd289
      ,'color':Color(0xffffd289)},

    {'string':0xff8d8edc
      ,'color':Color(0xff8d8edc)},


    {'string':0xffde91af
      ,'color':Color(0xffde91af)},

    {'string':0xfff9f9f7
      ,'color':Color(0xfff9f9f7)},

    {'string':0xff756EF3
      ,'color':Color(0xff756EF3)},

    {'string':0xff403e6c
      ,'color':Color(0xff403e6c)},




  ];
  late DateTime selected;
  // addNote(selected) async{
  //   Alerts.loading(context, "يتم الاضافة...");
  //   await FirebaseFirestore.instance.collection('notes').add({
  //     "note": note,
  //     "emoji": emoji.text,
  //     'date':formatDate(selected, [yyyy, '/', mm, '/', dd]),
  //     'time':formatDate(selected, [h,':',nn,':',ss," ",am]),
  //     'dateformat':formatDate(selected, [yyyy, '/', mm, '/', dd,' - ',h,':',nn,':',ss," ",am]),
  //     "color": noteColor.toString(),
  //     "state": true
  //   }).then((value) async => {
  //     await FirebaseFirestore.instance.collection('notes').doc(value.id).update(
  //         {'id':value.id}).then((value) => {
  //       NotificationService().scheduleNotification(
  //
  //
  //
  //
  //         scheduledNotificationDateTime: widget.selected.add(Duration(days: 1)), title: 'مركز المساعدة', body: note, payLoad: 'w',),
  //       notes.clear(),
  //       setState(() {
  //         newNote=true;
  //       }),
  //
  //       Navigator.pop(context),
  //       Navigator.pop(context),
  //       widget.onAdded(),
  //     }).catchError((onError){
  //       print(onError);
  //     })
  //
  //   }).catchError((onError){
  //     print(onError);
  //   });
  //
  //
  // }
  // Color noteColor = Color(ca);
  String notes = '';
FocusNode noteFocus=FocusNode();
  int noteColor=colors[Random().nextInt(colors.length)]['string'];
  @override
  void initState() {
    setState(() {
      emoji.text=emojis[Random().nextInt(emojis.length)];
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lang.get(context, key: LangKey.addNote),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
      ),
      body: Container(

        padding: const EdgeInsets.all(20),
        width: Sizes.width(context),
        height: Sizes.height(context),
        child:  KeyboardActions(
          config: buildConfig(context, [noteFocus]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Text(Lang.get(context, key: LangKey.addNote),style:const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 50,

                ),
                Container(

                  alignment: Alignment.center,
                  height: 50,
                  width: 300,
                  child: ListView.builder(

                    itemCount: colors.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            noteColor=colors[index]['string'];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: colors[index]['color'],

                          ),
                        ),
                      );

                    },

                  ),
                ),
                const SizedBox(
                  height: 50,

                ),
                Text(
                  Lang.get(context, key: LangKey.category),
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
                      return Lang.get(context, key: LangKey.categoryRequired);
                    }else{
                      return null;
                    }
                  },
                  onTap: (){

                    bottomSheetBlur(context, widget:Tags(onSelectedTags: (String selectedCategory) {
                      tags.text=selectedCategory;
                    },), height: 500, color: Theme.of(context).colorScheme.background);
                  },
                  controller: tags,
                  focusNode: FocusNode(),
                  readOnly: true,
                  hint:  Lang.get(context, key: LangKey.category),
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 50,

                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(noteColor),

                  ),
                  width: Sizes.width(context),
                  height: 300,
                  child: TextFormField(
                    focusNode: noteFocus,
                    maxLines:50,
                    controller: note,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontSize: 20, color: Color(noteColor).computeLuminance() > 0.5?Colors.black:Colors.white,fontWeight: FontWeight.w600),
                    textDirection: note.text.toString().isArabic&& note.text.isNotEmpty?TextDirection.rtl:TextDirection.ltr,
                    textAlign:  note.text.isNotEmpty? note.text.toString().isArabic  ?TextAlign.right:TextAlign.left:Locales.lang=="ar"?TextAlign.right:TextAlign.left,
                    onChanged: (t){
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      hintTextDirection:TextDirection.rtl,
                      border: InputBorder.none,
                      hintText: Lang.get(context, key: LangKey.enterNote),
                      hintStyle: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                MainButton(text: Lang.get(context, key: LangKey.add), width: Sizes.width(context), height: 50, onPressed: (){

                  if(note.text.isNotEmpty && tags.text.isNotEmpty){
                    String noteId=const Uuid().v4();
                    Notes noteData=Notes(notes: note.text,tag: tags.text,color: Color(noteColor).convertToHex.hex,id: noteId);
                    ref.read(notesViewModelProvider.notifier).addNote(context, data: noteData);
                    Navigator.pop(context);
                  }

                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
