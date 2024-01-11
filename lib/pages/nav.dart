
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/new/new_sheet.dart';
import 'package:khlfan_shtain/settings/sizes.dart';
import 'package:khlfan_shtain/utils/enum/screens_enum.dart';

import '../providers/bottom_nav_provider.dart';

class BottomNavigator extends ConsumerStatefulWidget {
  const BottomNavigator({super.key});

  @override
  ConsumerState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends ConsumerState<BottomNavigator> {
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavProvider).currentIndex;
    final List<ScreensEnum> screens = [
      ScreensEnum.home,
      ScreensEnum.tasks,
      ScreensEnum.profile,

    ];
    return Scaffold(
      body: SizedBox(
        height: Sizes.height(context),
        width: Sizes.width(context),

        child: Stack(
          children: [
Padding(
  padding: const EdgeInsets.only(bottom: 90),
  child: ref.watch(bottomNavProvider).showScreen(),
),
            Positioned(
              bottom: 0,
              child: Container(
                height: 90,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: Sizes.width(context),
                color: Theme.of(context).colorScheme.background,
                child: Row(
                  textDirection: TextDirection.ltr,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {

                        ref.read(bottomNavProvider.notifier).changeIndex(ScreensEnum.home);
                      },
                      icon: currentIndex ==ScreensEnum.home?Icon(
                        FluentIcons.home_24_filled,
                        color: Theme.of(context).colorScheme.primary,
                      ):Icon(
                        FluentIcons.home_24_regular,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ),
                    IconButton(
                      onPressed: () {


                        ref.read(bottomNavProvider.notifier).changeIndex(ScreensEnum.tasks);
                      },
                      icon: currentIndex ==ScreensEnum.tasks?Icon(
                        FluentIcons.task_list_square_ltr_16_filled,
                        color: Theme.of(context).colorScheme.primary,
                      ):Icon(
                        FluentIcons.task_list_square_ltr_16_regular,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                    ),
FloatingActionButton(onPressed: (){

  bottomSheetBlur(context, widget: const NewSheet(), height: 300,  color: Theme.of(context).colorScheme.background,);


},backgroundColor: Theme.of(context).colorScheme.primary,child: Icon(FluentIcons.add_24_filled,color: Theme.of(context).colorScheme.background,),),
                    IconButton(
                        onPressed: () {

                          ref.read(bottomNavProvider.notifier).changeIndex(ScreensEnum.profile);
                        },
                        icon: currentIndex ==ScreensEnum.profile?Icon(
                          FluentIcons.timeline_20_filled,
                          color: Theme.of(context).colorScheme.primary,
                        ):Icon(
                          FluentIcons.timeline_20_regular,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                    ),
                    IconButton(
                      onPressed: () {


                        ref.read(bottomNavProvider.notifier).changeIndex(ScreensEnum.profile);
                      },
                      icon: currentIndex ==ScreensEnum.profile?Icon(
                        FluentIcons.person_24_filled,
                        color: Theme.of(context).colorScheme.primary,
                      ):Icon(
                        FluentIcons.person_24_regular,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
