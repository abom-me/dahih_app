import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/pages/login.dart';
import 'package:khlfan_shtain/providers/auth_provider.dart';

import '../components/buttons.dart';
import '../components/text_field.dart';
import '../settings/routes.dart';
import '../settings/sizes.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _register = GlobalKey<FormState>();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل جديد',
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
                  "إنشاء حساب",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: Sizes.width(context) * 0.7,
                child: Text(
                  "من فضلك ادخل بياناتك لفتح حساب جديد",
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
                key: _register,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        focusNode: nameFocus,
                        controller: name,
                        hint: "الاسم",
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        valid: (text){
                          if(text!.isEmpty){
                            return "كيف راح نناديك بدون اسم؟ 😀";
                          }else{
                            return null;
                          }
                        },
                      ),
                      BoxSize.height(30),
                      TextFieldWidget(
                        focusNode: emailFocus,
                        controller: email,
                        hint: "البريد الإلكتروني",
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
                          FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9.@+]+")), // Allow specified characters
                        ],
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
                      TextFieldWidget(
                        focusNode: passwordFocus,
                        controller: password,
                        hint: "كلمة المرور",
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
                          FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9@.#$%&!]+")), // Allow specified characters
                        ],
                        valid: (text){
                          if(text!.isEmpty){
                            return "معقول حسابك بدون كلمة مرور؟ 😒";
                          }else if(text.length<6){
                            return "كلمة المرور سهلة مررة كل احد يتوقعها 👻";
                          }else{
                            return null;
                          }
                        },
                      ),



                      MainButton(text: "تسجيل", width: Sizes.width(context), height: 50, onPressed: (){
           if(_register.currentState!.validate()){
             ref.read(authProvider).register(context: context, email: email.text, password: password.text,name: name.text);

           }
                      }),
                      BoxSize.height(30),
                      GestureDetector(
                          onTap: () {
                            GoPage.push(page: LoginPage(), context: context);
                          },
                          child: Column(
                            children: [
                              Text(
                                " هل لديك حساب؟ ",
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "تسجيل دخول ",
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