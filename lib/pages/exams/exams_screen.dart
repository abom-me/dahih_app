import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/pages/exams/components/add.dart';
import 'package:khlfan_shtain/pages/exams/components/exam_card.dart';
import 'package:khlfan_shtain/utils/swipe_able_widget.dart';

import '../../components/try_again_widget.dart';
import '../../models/exam_model.dart';
import '../../providers/exams_provider.dart';
import '../../settings/sizes.dart';

class ExamsScreen extends ConsumerStatefulWidget {
  const ExamsScreen({super.key});

  @override
  ConsumerState createState() => _ExamsScreenState();
}

class _ExamsScreenState extends ConsumerState<ExamsScreen> {
  SwipeAbleController controller = SwipeAbleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          bottomSheetBlur(context, widget: const AddExam(), height: 600);
        },
        child: const Icon(FluentIcons.document_add_20_regular,size: 30,),
      ),
      appBar: AppBar(
        title: Text(Lang.get(context, key: LangKey.examsTable)),
      ),
      body: Container(
        width: Sizes.width(context),
        height: Sizes.height(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: RefreshIndicator(

          onRefresh: ()async{
            await ref.read(examsProvider.notifier).getExams();
            setState(() {});
          },
          child: FutureBuilder(
            future: ref.watch(examsProvider.notifier).getExams(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Exams> exams = snapshot.data as List<Exams>;
                return ListView.builder(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    return ExamCard(exam: exams[index],);
                  },
                );
              } else if (snapshot.hasError) {
                return tryAgainWidget(context,
                  onPressed: () {
                    ref.read(examsProvider.notifier).getExams();
                    setState(() {});
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
