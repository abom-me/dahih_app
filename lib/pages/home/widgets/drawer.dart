import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khlfan_shtain/components/alerts.dart';
import 'package:khlfan_shtain/pages/courses/courses_table.dart';
import 'package:khlfan_shtain/pages/exams/exams_screen.dart';
import 'package:khlfan_shtain/pages/privacy_policy.dart';
import 'package:khlfan_shtain/utils/enum/gender_enum.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';
import 'package:khlfan_shtain/viewmodel/settings_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

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
              border: const Border(
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
                  "assets/avatars/${userData.profileImage}",
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
            onTap: (){
              GoPage.push(page: const ExamsScreen(), context: context);
            },
          ),
          // ListTile(
          //   leading: Icon(FluentIcons.book_16_regular,color: Theme.of(context).colorScheme.primary,size: 30,),
          //   title: Text(Lang.get(context, key: LangKey.notes),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          // ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            onTap: (){
            Navigator.pop(context);
            Alert.snackbar(context, text: Lang.get(context, key: LangKey.soon));
            },
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
            leading: Switch(value: ref.read(settingsViewModelProvider.notifier).getDailyNotifications(), onChanged: (value) {

    ref.watch(settingsViewModelProvider.notifier).dailyNotifications(value, context);

    }),
            title: Text(Lang.get(context, key: LangKey.dailyMessages),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            onTap: () async {
              if (!await launchUrl(Uri.parse("https://twitter.com/abom_me"))){
              // throw Exception('Could not launch $_url');
              }
            },
        
            leading: SvgPicture.asset("assets/images/x-twitter.svg",width: 30,color: Theme.of(context).colorScheme.primary,),
            title: Text(Lang.get(context, key: LangKey.followDevTwitt),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
onTap: () async {
  if (!await launchUrl(Uri.parse("https://instagram.com/abom.me"))){
    // throw Exception('Could not launch $_url');
  }
    },
            leading: SvgPicture.asset("assets/images/instagram.svg",width: 30,color: Theme.of(context).colorScheme.primary,),

            title: Text(Lang.get(context, key: LangKey.followDevInsta),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          ),
          ListTile(
            onTap: () async {
            GoPage.push(page: const PrivacyPolicy(), context: context);
            },
            leading: Icon(FluentIcons.info_20_regular,color: Theme.of(context).colorScheme.primary,size: 30,),

            title: Text(Lang.get(context, key: LangKey.privacyPolicyTitle),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
          ),
        ],
      ),
    );
  }
}