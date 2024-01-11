

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/new/task/new_task.dart';

import 'new_sheet_btns.dart';

class NewSheet extends ConsumerWidget {
  const NewSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
child: Column(
        children: [
          NewSheetButtons(
            duration: const Duration(milliseconds: 100),
            icon: FluentIcons.task_list_square_add_20_regular,
            text: Lang.get(context, key: LangKey.addTasks),
            onTap: () {
              Navigator.of(context).pop();
bottomSheetBlur(context, widget: const NewTaskPage(), height: 700, color: Theme.of(context).colorScheme.background);

          }, ),
          NewSheetButtons(
            duration: const Duration(milliseconds: 300),
            icon: FluentIcons.alert_12_regular,
            text: Lang.get(context, key: LangKey.addReminder),
            onTap: () {

            }, ),
          NewSheetButtons(
            duration: const Duration(milliseconds: 500),
            icon: FluentIcons.note_add_28_regular,
    text: Lang.get(context, key: LangKey.addNote),

            onTap: () {

          }, ),
        ],
      ),
    ) ;
  }
}

