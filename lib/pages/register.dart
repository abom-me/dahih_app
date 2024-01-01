import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/buttons.dart';
import '../components/text_field.dart';
import '../settings/routes.dart';
import '../settings/sizes.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController email = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController password = TextEditingController();

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
                    fontWeight: FontWeight.w100),
              ),
            ),
            BoxSize.height(50),
            Form(
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: name,
                      hint: "الاسم",
                      keyboardType: TextInputType.name,
                      isPassword: false,
                    ),
                    BoxSize.height(30),
                    TextFieldWidget(
                      controller: email,
                      hint: "البريد الإلكتروني",
                      keyboardType: TextInputType.emailAddress,
                      isPassword: false,
                    ),
                    BoxSize.height(30),
                    TextFieldWidget(
                      controller: password,
                      hint: "كلمة المرور",
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
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

                    MainButton(text: "تسجيل دخول", width: Sizes.width(context), height: 50, onPressed: (){}),
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
    );
  }
}