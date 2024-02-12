import 'package:color_hex/color_hex.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/new/new_sheet_btns.dart';
import 'package:khlfan_shtain/settings/routes.dart';

import '../../settings/sizes.dart';
import '../../viewmodel/notes_viewmodel.dart';
import 'component/addnote.dart';

class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  String selectedTag = "all";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text(Lang.get(context, key: LangKey.notes)),
        actions: [
          IconButton(
            onPressed: () {
              GoPageAnimated.push(page: const AddNote(), context: context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Sizes.width(context),
        height: Sizes.height(context),
        child:Column(
          children: [
            FutureBuilder(future: ref.watch(notesViewModelProvider).getTags(),
                builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(
                  margin: const EdgeInsets.only(top: 10,bottom: 10),
                  width: Sizes.width(context),
                  height: 40,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            selectedTag = "all";
                            setState(() {});
                            // ref.read(notesViewModelProvider.notifier).selectTag(snapshot.data![index]);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                            if(!selectedTag.contains("all"))    BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: selectedTag.contains("all") ? Theme.of(context).colorScheme.primary : Colors.white,
                            ),
                            child: Center(child: Text(Lang.get(context, key: LangKey.all),style:   TextStyle(fontSize: 17, color:selectedTag.contains("all") ?Colors.white:Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w600),)),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: (){
                                bottomSheetBlur(context,  height: 300,
                                  widget: Container(
                                    width: Sizes.width(context),
                                    height: 300,
                                    child: Column(
                                      children: [
                                        NewSheetButtons(text: Lang.get(context, key: LangKey.deleteTag), icon: FluentIcons.delete_12_regular, onTap: (){
                                          ref.read(notesViewModelProvider).deleteTag(context,tag:snapshot.data![index]);
                                          Navigator.pop(context);
                                        }, duration: const Duration(milliseconds: 100),),
                                      ],
                                    ),
                                  ),);
                              },
                              onTap: (){
                                selectedTag = snapshot.data![index];
                                setState(() {});
                                // ref.read(notesViewModelProvider.notifier).selectTag(snapshot.data![index]);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    if(!selectedTag.contains(snapshot.data![index]))     BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: selectedTag.contains(snapshot.data![index]) ? Theme.of(context).colorScheme.primary : Colors.white,
                                ),
                                child: Center(child: Text(snapshot.data![index],style:   TextStyle(fontSize: 17, color:selectedTag.contains(snapshot.data![index]) ?Colors.white:Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w600),)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
                }
            ),
            FutureBuilder(future: ref.watch(notesViewModelProvider).getNotes(filter: selectedTag),

                builder: (context, snapshot) {

              if(snapshot.hasData){
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: (){
                        bottomSheetBlur(context,  height: 300,
                          widget: Container(
                            width: Sizes.width(context),
                            height: 300,
                            child: Column(
                              children: [
                                NewSheetButtons(text: Lang.get(context, key: LangKey.deleteNote), icon: FluentIcons.delete_12_regular, onTap: (){
                                  ref.read(notesViewModelProvider).deleteNote(context,id:snapshot.data![index].id!);
                                  Navigator.pop(context);
                                }, duration: Duration(milliseconds: 100),),
                              ],
                            ),
                          ),);
                      },
                      onTap: (){
                        bottomSheetBlur(context, widget: Container(
                          padding: const EdgeInsets.all(20),
                          width: Sizes.width(context),
                          height: 500,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].notes!,style:  TextStyle(fontSize: 17, color:snapshot.data![index].color!.convertToColor.computeLuminance()> 0.5?Colors.black:Colors.white,fontWeight: FontWeight.w600),),
                              ],
                            ),
                          ),
                        ), height: 500,color: snapshot.data![index].color!.convertToColor);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: snapshot.data![index].color!.convertToColor,

                        ),
                        width: Sizes.width(context),
                        height: 350,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color:Colors.black.withOpacity(0.1),
                            ),
                              child: Center(child: Text(snapshot.data![index].tag!,style:  TextStyle(fontSize: 13, color:snapshot.data![index].color!.convertToColor.computeLuminance()> 0.5?Colors.black:Colors.white,fontWeight: FontWeight.w600),)),

                            ),
                            Text(snapshot.data![index].notes!.length>40?"${snapshot.data?[index].notes!.substring(0,39)}...":snapshot.data![index].notes!,style:  TextStyle(fontSize: 17, color:snapshot.data![index].color!.convertToColor.computeLuminance()> 0.5?Colors.black:Colors.white,fontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Container();
                }
                  ),
          ],
        ),
      )
    );
  }
}
