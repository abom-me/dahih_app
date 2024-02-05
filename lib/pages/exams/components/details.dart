import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/sizes.dart';


class ExamDetails extends ConsumerWidget {
  const ExamDetails( {super.key,required this.i});
final int i;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
        width: Sizes.width(context),
        // height: Sizes.height(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Hero(tag: "exam_$i", child: Container(
              child:  Container(
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(FluentIcons.book_open_16_filled,color: Theme.of(context).colorScheme.primary,size: 30,),
                        const SizedBox(width: 10,),
                        Text("المادة $i",style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(FluentIcons.calendar_rtl_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                            const SizedBox(width: 10,),
                            Text("التاريخ $i",style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 17),),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(FluentIcons.home_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                            const SizedBox(width: 10,),
                            Text("التاريخ $i",style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 17),),
                          ],
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(FluentIcons.clock_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                            const SizedBox(width: 10,),
                            Text("التاريخ $i",style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 17),),
                          ],
                        ),

                        Row(
                          children: [
                            Icon(FluentIcons.timer_12_regular,color: Theme.of(context).colorScheme.primary,size: 25,),
                            const SizedBox(width: 10,),
                            Text("التاريخ $i",style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.bold,fontSize: 17),),
                          ],
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ))
          ],
        )
    );
  }
}