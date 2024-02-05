


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:khlfan_shtain/components/buttons.dart';

import '../../auto_local/lang.dart';
import '../../settings/sizes.dart';
import '../../viewmodel/promo_timer_viewmodel.dart';
class PomodoroTimer extends ConsumerStatefulWidget {
  const PomodoroTimer({super.key});

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends ConsumerState<PomodoroTimer> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Lang.get(context, key: LangKey.pomodoroTechnique) ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '${ref.watch(promoTimerViewModelProvider).minutes}:${ref.watch(promoTimerViewModelProvider).seconds.toString().padLeft(2, '0')}',
                  style:  TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),
                ),

                SizedBox(

                  height: Sizes.width(context) *0.8,
                  width: Sizes.width(context) *0.8,

                  child:   CircularProgressIndicator(
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    color: Theme.of(context).colorScheme.primary,
                    value: (ref.watch(promoTimerViewModelProvider).minutes * 60 + ref.watch(promoTimerViewModelProvider).seconds) / 1500,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  ),),


              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              MainButton( width: 120, height: 50,

                onPressed: () {

                ref.read(promoTimerViewModelProvider.notifier).changeisRunning();
                if ( ref.watch(promoTimerViewModelProvider.notifier).isRunning) {
                  ref.read(promoTimerViewModelProvider.notifier).startTimer();
                } else {
                  ref.read(promoTimerViewModelProvider.notifier).pushTimer();
                }

              },
                text: ref.watch(promoTimerViewModelProvider).isRunning
                    ?  Lang.get(context, key: LangKey.pause): Lang.get(context, key: LangKey.start),
              ),
const SizedBox(width: 40,),
                SecButton(text: Lang.get(context, key: LangKey.reset),
                    width: 120,
                    height: 50,
                    onPressed: (){
                      ref.watch(promoTimerViewModelProvider.notifier).resetTimer();
                    }),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
