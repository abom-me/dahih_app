import 'package:flutter/material.dart';


Widget actionButton(BuildContext context,{required GestureTapCallback onTap,required IconData icon}){
  return  InkWell(
    borderRadius: BorderRadius.circular(50),
    onTap: onTap,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary,width: 0.5),
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Icon(icon,color: Theme.of(context).colorScheme.primary,),
    ),
  );
}
