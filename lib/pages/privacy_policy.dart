import 'package:flutter/material.dart';
import 'package:khlfan_shtain/auto_local/lang.dart';


class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(Lang.get(context, key: LangKey.privacyPolicyTitle)),
      ),
      body:  Center(
        child: Text(Lang.get(context, key: LangKey.privacyPolicy)),
      ),
    );
  }
}
