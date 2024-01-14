import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/courses/courses_table.dart';
import 'package:khlfan_shtain/utils/enum/gender_enum.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';
import 'package:khlfan_shtain/viewmodel/settings_viewmodel.dart';

import '../../../auto_local/lang.dart';
import '../../../settings/routes.dart';


class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 120),
              clipBehavior: Clip.hardEdge,
            alignment: Alignment.bottomCenter,
            // height: 210,
            decoration:  BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              border: Border(
                bottom: BorderSide.none
              )
            ),

              child: Container(
            // width: Sizes.width(context),
            // height: 210,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userData.profileImage=="" || userData.profileImage==null ? userData.gender==GenderEnum.male.gender?Image.asset(

                  "assets/avatars/i5.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ):Image.asset(

                  "assets/avatars/i43.png",
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ): Image.asset(
                  userData.profileImage!,
                  fit: BoxFit.cover,
                  width: 130,
                  height: 130,
                ),
                const SizedBox(height: 10,),
                Text(userData.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),)
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
            onTap: (){
            ref.read(settingsViewModelProvider.notifier).logout(context);
            },
            leading: Icon(FluentIcons.sign_out_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
            title: Text(Lang.get(context, key: LangKey.logout),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
}