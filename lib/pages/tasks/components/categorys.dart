import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/models/category_model.dart';
import 'package:khlfan_shtain/providers/category_provider.dart';

import '../../../components/try_again_widget.dart';

class Categories extends ConsumerStatefulWidget {
  const Categories({super.key, required this.onSelectedCategory});

  final Function(String selectedCategory) onSelectedCategory;

  @override
  ConsumerState createState() => _CategoriesState();
}

class _CategoriesState extends ConsumerState<Categories> {
  TextEditingController categoryController = TextEditingController();
  bool addCategory = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addCategory
            ? Container(
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          height: 100,
              child: Row(
                  children: [
                    Expanded(
                        child: Form(
                            child: SizedBox(

                              child: TextFieldWidget(
                                  controller: categoryController,
                                  focusNode: FocusNode(),
                                  hint: Lang.get(context, key: LangKey.categoryName),
                                  keyboardType: TextInputType.text),
                            ))),
                    IconButton(onPressed: () {
                      addCategory = false;
                      setState(() {});
                      if(categoryController.text.isNotEmpty){
                        ref.read(categoryProvider.notifier).addCategories(categoryController.text);
                        categoryController.clear();
                        widget.onSelectedCategory(categoryController.text);
                        Navigator.pop(context);
                      }
                    }, icon: Icon(Icons.add,color: Theme.of(context).colorScheme.primary,size: 30,))
                  ],
                ),
            )
            : GestureDetector(
                onTap: () {
                  addCategory = true;
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
            future: ref.watch(categoryProvider.notifier).getCategories(),
            builder: (context, snapshot) {
             if(snapshot.hasData){
               List<CategoryModel> categories = snapshot.data!;
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
                         onTap: () {
                           widget.onSelectedCategory(categories[i].name!);
                            Navigator.pop(context);
                         },
                         title: Text(categories[i].name!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
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
