import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales2/flutter_locales2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/pages/home/widgets/courses.dart';
import 'package:khlfan_shtain/pages/home/widgets/tasks.dart';
import 'package:khlfan_shtain/repo/courses.dart';
import 'package:khlfan_shtain/utils/check_arabic_text.dart';
import 'package:khlfan_shtain/utils/day_to_arabic.dart';
import 'package:khlfan_shtain/utils/global_keys.dart';

import '../../components/try_again_widget.dart';
import '../../models/course_model.dart';
import '../../providers/home_provider.dart';
import '../../settings/sizes.dart';
import '../../utils/enum/course_status_enum.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(

            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1)
            ),
            child: IconButton(

              onPressed: () {

              },
              icon: const Icon(FluentIcons.calendar_ltr_24_regular),
            ),
          ),
          Text(
            "${DateFormat('EEEE').format(DateTime.now()).dayToArabic} ، ${DateFormat('d').format(DateTime.now())} / ${DateFormat('MM').format(DateTime.now())}",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,

            ),

          ),
          Container(

            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.background,
              border: Border.all(color: Theme.of(context).colorScheme.secondary,width: 0.1)
            ),
            child: IconButton(

              onPressed: () {
if(Locales.lang=="ar"){
  Locales.change(context, "en");

}else{
  Locales.change(context, "ar");
}
              },
              icon: const Icon(Icons.notifications_none_outlined),
            ),
          ),
          ],
        )
      ),
      body: Container(
        height: Sizes.height(context),
        width: Sizes.width(context),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          const SizedBox(height: 20,),
             const HomeHeader(),
              const SizedBox(height: 20,),
           TodayCourses(),
              const SizedBox(height: 20,),
            HomeTasks()
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: Sizes.width(context),
       height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset("assets/images/header_light.svg",height: 100,width: 100,),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${Lang.get(context, key: LangKey.welcomeBack)} ${userData.name} 🤩",style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w800,

            ),),
            const SizedBox(height: 5,),

            Text("${Lang.get(context, key: LangKey.letsCheckYourTasks)} 📝",style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w800,

            ),),
          ],
        ),

        ],
      ),
    );
  }
}