
import 'package:flutter/material.dart';

Widget tryAgainWidget({required Function onPressed}) {
  return Column(
    children: [
      const Center(child: Text("حدث خطأ ما",style: TextStyle(fontSize: 17),),),
      const SizedBox(height: 10,),
      TextButton(onPressed: (){
        onPressed();

      }, child: const Text("اعادة المحاولة",style: TextStyle(fontWeight: FontWeight.bold),))
    ],
  );
}