import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/models/exam_model.dart';

import '../../../settings/sizes.dart';


class ExamDetails extends ConsumerWidget {
  const ExamDetails( {super.key,required this.data});
final Exams data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(

      height:500,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      width: Sizes.width(context),
      child: SingleChildScrollView(
        child: Text(data.examDetails??"",style: const TextStyle(
          fontSize: 20,
        ),),
      ),
    );
  }
}