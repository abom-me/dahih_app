
import 'package:flutter/material.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';

Widget tryAgainWidget(context ,{required Function onPressed}) {
  return Column(
    children: [

      Center(child: Text(Lang.get(context, key: LangKey.somethingWentWrong),style: const TextStyle(fontSize: 17),),),
      const SizedBox(height: 10,),
      TextButton(onPressed: (){
        onPressed();

      }, child:  Text(Lang.get(context, key: LangKey.tryAgain),style: const TextStyle(fontWeight: FontWeight.bold),))
    ],
  );
}