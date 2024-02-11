import 'package:flutter/material.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/text_field.dart';

class FullScreenFieldWidget extends StatefulWidget {
  const FullScreenFieldWidget({super.key, required this.title, required this.onDone, this.oldText});
  final String title;
  final void Function(String) onDone;
final String? oldText;

  @override
  State<FullScreenFieldWidget> createState() => _FullScreenFieldWidgetState();
}

class _FullScreenFieldWidgetState extends State<FullScreenFieldWidget> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    controller.text=widget.oldText??'';
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () {
              widget.onDone(controller.text);
              Navigator.pop(context);
            },
            child: Text(Lang.get(context, key: LangKey.save),style: TextStyle(fontSize: 20),),
          )
        ],
      ),
      body: Container(
       height: 500,
          padding: const EdgeInsets.all(20),
          child: TextFieldWidget(
            multiLine: true,
              maxline: 50,
              controller: controller, focusNode: FocusNode(), hint: widget.title, keyboardType: TextInputType.multiline),
      ),
    );
  }
}
