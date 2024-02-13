


import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/models/course_model.dart';
import 'package:khlfan_shtain/pages/new/new_sheet_btns.dart';
import 'package:khlfan_shtain/settings/sizes.dart';

import '../../../providers/course_table_provider.dart';


class CourseDetailsBottomSheet extends ConsumerStatefulWidget {
  const CourseDetailsBottomSheet({super.key,required this.course, });
final Course course;
  @override
  ConsumerState createState() => _CourseDetailsBottomSheetState();
}

class _CourseDetailsBottomSheetState
    extends ConsumerState<CourseDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: Sizes.width(context),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          NewSheetButtons(text: Lang.get(context, key: LangKey.deleteCourse), icon: FluentIcons.delete_12_regular, onTap: (){
            ref.read(courseTableProvider).deleteCourse(context,widget.course.id!);
          }, duration: const Duration(milliseconds: 100),),
          NewSheetButtons(text: Lang.get(context, key: LangKey.resetNotification), icon: FluentIcons.alert_12_regular, onTap: (){
            ref.read(courseTableProvider).resetNotification(context,widget.course);
          }, duration: const Duration(milliseconds: 100),),
        ],
      ),
    );
  }
}
