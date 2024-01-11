import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/courses/courses_table.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';
import 'package:khlfan_shtain/viewmodel/settings_viewmodel.dart';

import '../../../auto_local/lang.dart';
import '../../../settings/routes.dart';


class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(

        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              // color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              border: Border(
                bottom: BorderSide.none
              )
            ),

              child: Container(
            // width: Sizes.width(context),
            // height: 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: Icon(FluentIcons.person_20_regular,color: Theme.of(context).colorScheme.background,size: 50,),
                ),
                const SizedBox(height: 10,),
                Text(userData.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondary),)
              ],
            ),
          )),

ListTile(
  onTap: (){
GoPage.push(page: const CoursesTable(), context: context);
    },
leading: Icon(FluentIcons.calendar_ltr_24_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
title: Text(Lang.get(context, key: LangKey.studySchedule),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            leading: Icon(FluentIcons.calendar_agenda_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.examsTable),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            leading: Icon(FluentIcons.book_16_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.notes),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            leading: Icon(FluentIcons.home_add_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.homeLayout),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            onTap: (){
              final currentLang = Locales.lang;
              ref.watch(settingsViewModelProvider.notifier).changeLang(context,currentLang == "ar" ? "en" : "ar");
            },
            leading: Icon(FluentIcons.local_language_16_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.changeLanguage),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            onTap: (){
              final currentTheme = ref.read(settingsViewModelProvider).theme;
              ref.watch(settingsViewModelProvider.notifier).changeTheme(currentTheme == ThemeMode.dark ? true : false);
            },
            leading: Icon(FluentIcons.dark_theme_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.theme),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            leading: Icon(FluentIcons.sign_out_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.logout),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
}