import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';
import 'package:khlfan_shtain/providers/auth_provider.dart';

import '../../components/buttons.dart';
import '../../components/text_field.dart';
import '../../settings/sizes.dart';
import '../../utils/enum/gender_enum.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  // TextEditingController email = TextEditingController();
GenderEnum gender = GenderEnum.male;
  TextEditingController name = TextEditingController();
  // TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _register = GlobalKey<FormState>();
  // FocusNode emailFocus = FocusNode();
  // FocusNode passwordFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          // Lang.get(context, key: LangKey.newRegistration),
          ""
        ),
      ),
      body: Container(
        height: Sizes.height(context),
        width: Sizes.width(context),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: Sizes.width(context),
                child:  Text(
                  "${Lang.get(context, key: LangKey.welcomeWithUs)}\n ${name.text.replaceAll(" ", "").isEmpty?" 🤔":"${name.text} 👋"}",
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: Sizes.width(context) * 0.7,
                child: Text(
                  "${Lang.get(context, key: LangKey.enterYourData)} 🥳",
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        onChange: (text){

                          setState(() {

                          });
                        },
                        focusNode: nameFocus,
                        controller: name,
                        hint: Lang.get(context, key: LangKey.name),
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        valid: (text){
                          if(text!.isEmpty){
                            return "${Lang.get(context, key: LangKey.nameEmpty)} 😀";
                          }else{
                            return null;
                          }
                        },
                      ),
                      // BoxSize.height(30),

                        // SizedBox(
                        //   width: Sizes.width(context),
                        //   height: 96,
                        //   child:Row(
                        //     children: [
                        //
                        //       Row(
                        //         children: [
                        //           Text(Lang.get(context, key: LangKey.selectGender,),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                        //           Row(
                        //             children: [
                        //               Radio(
                        //                 value: GenderEnum.male,
                        //                 groupValue: gender,
                        //                 onChanged: ( value) {
                        //                   gender=value;
                        //                   setState(() {
                        //
                        //                   });
                        //
                        //
                        //                 },
                        //               ),
                        //       Text(Lang.get(context, key: LangKey.male),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                        //             ],
                        //           ),
                        //           Row(
                        //             children: [
                        //               Radio(
                        //
                        //                 value: GenderEnum.female,
                        //                 groupValue: gender,
                        //                 onChanged: ( value) {
                        //                   gender=value;
                        //                   setState(() {
                        //
                        //                   });
                        //
                        //
                        //                 },
                        //               ),
                        //       Text(Lang.get(context, key: LangKey.female),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                        //             ],
                        //           ),
                        //
                        //
                        //         ],
                        //       ),
                        //       Expanded(
                        //         // flex: 1,
                        //         child: TextFormField(
                        //
                        //           readOnly: true,
                        //           decoration: const InputDecoration(
                        //             contentPadding: EdgeInsets.zero,
                        //             disabledBorder: InputBorder.none,
                        //             errorBorder: InputBorder.none,
                        //             focusedBorder: InputBorder.none,
                        //             enabledBorder: InputBorder.none,
                        //             focusedErrorBorder: InputBorder.none,
                        //
                        //           ),
                        //           validator: (v){
                        //             if(gender ==null){
                        //               return Lang.get(context, key: LangKey.genderEmpty);
                        //             }else{
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //       )
                        //
                        //     ],
                        //   ) ,
                        // ),
                      // BoxSize.height(30),
                      // TextFieldWidget(
                      //   focusNode: emailFocus,
                      //   controller: email,
                      //   hint: Lang.get(context, key: LangKey.email),
                      //   keyboardType: TextInputType.emailAddress,
                      //   isPassword: false,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
                      //     FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9.@+]+")), // Allow specified characters
                      //   ],
                      //   valid: (text){
                      //     if(text!.isEmpty){
                      //       return "${Lang.get(context, key: LangKey.emailEmpty)} 🤓";
                      //     }else if(!text.contains("@")){
                      //       return "${Lang.get(context, key: LangKey.emailNotValid)} 🤨";
                      //     }else{
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // BoxSize.height(30),
                      // TextFieldWidget(
                      //   focusNode: passwordFocus,
                      //   controller: password,
                      //   hint: Lang.get(context, key: LangKey.password),
                      //   keyboardType: TextInputType.visiblePassword,
                      //   isPassword: true,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
                      //     FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9@.#$%&!]+")), // Allow specified characters
                      //   ],
                      //   valid: (text){
                      //     if(text!.isEmpty){
                      //       return "${Lang.get(context, key: LangKey.passwordEmpty)} 😒";
                      //     }else if(text.length<6){
                      //       return "${Lang.get(context, key: LangKey.passwordEasy)} 👻";
                      //     }else{
                      //       return null;
                      //     }
                      //   },
                      // ),



                      MainButton(text: Lang.get(context, key: LangKey.save), width: Sizes.width(context), height: 50, onPressed: (){
           if(_register.currentState!.validate()){
             ref.read(authProvider).register(context: context, name: name.text, gender: gender!);

           }
                      }),
                      // BoxSize.height(30),
                      // GestureDetector(
                      //     onTap: () {
                      //       GoPage.push(page: const LoginPage(), context: context);
                      //     },
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           Lang.get(context, key: LangKey.dontHaveAccount),
                      //           style: TextStyle(
                      //               color: Theme.of(context).colorScheme.onBackground,
                      //               fontSize: 17,
                      //               fontWeight: FontWeight.w500),
                      //         ),
                      //         Text(
                      //           Lang.get(context, key: LangKey.login),
                      //           style: TextStyle(
                      //               color: Theme.of(context).colorScheme.primary,
                      //               fontSize: 17,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //       ],
                      //     )),

                    ],
                  )),
            ],
          ),
        ),
      ),
    );

  }
}