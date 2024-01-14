import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/components/bottom_sheet.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/pages/auth/components/repassword.dart';
import 'package:khlfan_shtain/pages/auth/register.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/settings/sizes.dart';

import '../../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  final GlobalKey<FormState> _login = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,) {




    return Scaffold(

      appBar: AppBar(
        title:  Text(
          Lang.get(context, key: LangKey.login),
        ),
      ),
      body: Container(
        height: Sizes.height(context),
        width: Sizes.width(context),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: Sizes.width(context),
                child:  Text(
                  "${Lang.get(context, key: LangKey.welcomeBack)} 👋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: Sizes.width(context) * 0.7,
                child: Text(
                  Lang.get(context, key: LangKey.pleaseEnterYourEmailPassweord),
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.5),
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ),
              BoxSize.height(50),
              Form(
                key: _login,
                  child: Column(
                children: [
                  TextFieldWidget(
                    focusNode: emailFocus,
                    controller: email,
                    hint: Lang.get(context, key: LangKey.email),
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    valid: (text){
                      if(text!.isEmpty){
                        return "${Lang.get(context, key: LangKey.emailEmpty)} 🤓";
                      }else if(!text.contains("@")){
                        return "${Lang.get(context, key: LangKey.emailNotValid)} 🤨";
                      }else{
                        return null;
                      }
                    },
                  ),
                  BoxSize.height(30),

                  InkWell(

                    child: TextFieldWidget(
                      focusNode: passwordFocus,
                      controller: password,
                      hint: Lang.get(context, key: LangKey.password),
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      valid: (text){
                        if(text!.isEmpty){
                          return "${Lang.get(context, key: LangKey.passwordEmpty)} 😒";
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),
                  BoxSize.height(10),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    // width: Sizes.width(context),
                    child: InkWell(
                      onTap: () {
                        bottomSheetBlur(context, widget: ResetPasswordScreen(), height: 400, color: Colors.white);
                      },
                        child: Text(
                      Lang.get(context, key: LangKey.forgotPassword),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                  ),

                 MainButton(text:  Lang.get(context, key: LangKey.login), width: Sizes.width(context), height: 50, onPressed: (){
                    if(_login.currentState!.validate()){
                      ref.read(authProvider).login(email:email.text, password:password.text, context:context);
                    }
                 }),
                BoxSize.height(30),
                  GestureDetector(
                      onTap: () {
                        GoPage.push(page: const RegisterPage(), context: context);
                      },
                      child: Column(
                        children: [
                          Text(
                            Lang.get(context, key: LangKey.dontHaveAccount),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            Lang.get(context, key: LangKey.registerNow),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),

                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
