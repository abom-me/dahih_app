import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';

import '../../../auto_local/lang.dart';
import '../../../providers/auth_provider.dart';
import '../../../settings/sizes.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _resetPassword = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child:  Column(
        children: [
          Text(Lang.get(context, key: LangKey.resetPassword),style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: Sizes.width(context) * 0.7,
            child: Text(Lang.get(context, key: LangKey.enterEmailToReset),style:  TextStyle(fontSize: 16,color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.5),),textAlign: TextAlign.center,),
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
            key: _resetPassword,
            child: TextFieldWidget(controller: controller, focusNode: FocusNode(), hint: Lang.get(context, key: LangKey.email), keyboardType: TextInputType.emailAddress,valid: (value){
              if(value!.isEmpty||!value.contains("@")){
                return " ";
              }else{
              return null;
              }

            },),
          ),
        
          MainButton(text: Lang.get(context, key: LangKey.send), width: Sizes.width(context), height: 50, onPressed: (){
if(_resetPassword.currentState!.validate()){
  ref.read(authProvider).resetPassword( context: context, email: controller.text,);

}else{

}

          })
      
        ],
      ),
    );
  }
}
