import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/text_field.dart';

import '../../../components/try_again_widget.dart';
import '../../../viewmodel/notes_viewmodel.dart';

class Tags extends ConsumerStatefulWidget {
  const Tags({super.key, required this.onSelectedTags});

  final Function(String selectedCategory) onSelectedTags;

  @override
  ConsumerState createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Tags> {
  TextEditingController tagsController = TextEditingController();
  bool addTags = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addTags
            ? Container(
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          height: 100,
          child: Row(
            children: [
              Expanded(
                  child: Form(
                      child: SizedBox(

                        child: TextFieldWidget(
                            controller: tagsController,
                            focusNode: FocusNode(),
                            hint: Lang.get(context, key: LangKey.categoryName),
                            keyboardType: TextInputType.text),
                      ))),
              IconButton(onPressed: () {
                addTags = false;
                setState(() {});
                if(tagsController.text.isNotEmpty){
                  ref.read(notesViewModelProvider.notifier).addTag(context,tag:tagsController.text);

                  Navigator.pop(context);
                  widget.onSelectedTags(tagsController.text);
                }
              }, icon: Icon(Icons.add,color: Theme.of(context).colorScheme.primary,size: 30,))
            ],
          ),
        )
            : GestureDetector(
          onTap: () {
            addTags = true;
            setState(() {});
          },
          child: Container(
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                // color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  Icon(Icons.add,
                      size: 25,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Lang.get(context, key: LangKey.addCategory),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
        ),
        Expanded(
          child: FutureBuilder(
              future: ref.read(notesViewModelProvider.notifier).getTags(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<String> categories = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),width: 0.5
                                  )
                              )
                          ),
                          child: ListTile(
                            onLongPress: () {
                              ref.read(notesViewModelProvider.notifier).deleteTag(context,tag:categories[i]);
                              setState(() {});
                            },

                            onTap: () {
                              widget.onSelectedTags(categories[i]);
                              Navigator.pop(context);
                            },

                            title: Text(categories[i],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                          ),
                        );
                      });
                }else if(snapshot.hasError){
                  return tryAgainWidget(context,onPressed: (){
                    setState(() {});
                  });

                }else{
                  return const Center(child: CircularProgressIndicator());
                }
              }
          ),
        )
      ],
    );
  }
}
