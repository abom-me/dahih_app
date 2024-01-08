import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/components/buttons.dart';
import 'package:khlfan_shtain/components/text_field.dart';
import 'package:khlfan_shtain/pages/register.dart';
import 'package:khlfan_shtain/settings/routes.dart';
import 'package:khlfan_shtain/settings/sizes.dart';

import '../providers/auth_provider.dart';

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
  GlobalKey<FormState> _login = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context,) {




    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'تسجيل دخول',
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
                child: const Text(
                  "مرحبا بعودتك 👋",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: Sizes.width(context) * 0.7,
                child: Text(
                  "من فضلك ادخل البريد الالكتروني و كلمة المرور لتسجيل الدخول",
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
                    hint: "البريد الإلكتروني",
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    valid: (text){
                      if(text!.isEmpty){
                        return "كيف بتسجل بدون بريد؟🤓";
                      }else if(!text!.contains("@")){
                        return "هذا البريد غير صالح 🤨";
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
                      hint: "كلمة المرور",
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      valid: (text){
                        if(text!.isEmpty){
                          return "معقول حسابك بدون كلمة مرور؟ 😒";
                        }else{
                          return null;
                        }
                      },
                    ),
                  ),
                  BoxSize.height(10),
                  SizedBox(
                    width: Sizes.width(context),
                    child: InkWell(
                        child: Text(
                      "نسيت كلمة المرور؟",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
                  ),

                 MainButton(text: "تسجيل دخول", width: Sizes.width(context), height: 50, onPressed: (){
                    if(_login.currentState!.validate()){
                      print("login");
                      ref.read(authProvider).login(email:email.text, password:password.text, context:context);
                    }
                 }),
                BoxSize.height(30),
                  GestureDetector(
                      onTap: () {
                        GoPage.push(page: RegisterPage(), context: context);
                      },
                      child: Column(
                        children: [
                          Text(
                            " ليس لديك حساب؟ ",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onBackground,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "سجل الان ",
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
