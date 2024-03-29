import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/global_keys.dart';



bottomSheetBlur(BuildContext context,{required widget,required double height, Color? color}){

  showModalBottomSheet(
        barrierColor: Colors.black.withOpacity(0.2),
        isScrollControlled: true,
        elevation: 0,
        context: scaffoldKey.currentContext!, builder: (d){
      return BackdropFilter(

        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          // width: Sizes.width(context),
          height: height,
          padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            color:color?? Theme.of(d).colorScheme.background,

          ),
          child: Column(

            children: [
             Container(
               width: 50,
               height: 5,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.grey[300],
               ),
             ),
              Expanded(child: widget)
            ],
          ),
        ),
      );
    });}

