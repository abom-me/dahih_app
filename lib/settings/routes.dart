import 'package:flutter/material.dart';



class GoPage {
  static pushR({required Widget page, required BuildContext context}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_)=>page));
  }

  static push({required Widget page, required BuildContext context}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_)=>page));
  }

  static pushF({required Widget page, required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_)=>page),
        (route) => false);
  }
}
