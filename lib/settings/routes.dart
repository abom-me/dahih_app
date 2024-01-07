import 'package:flutter/material.dart';



class GoPage {
  static pushR({required Widget page, required BuildContext context}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_)=>page));
  }

  static push({required Widget page, required BuildContext context}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_)=>page,));
  }

  static pushF({required Widget page, required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_)=>page),
        (route) => false);
  }
}


class GoPageAnimated {
  static pushR({required Widget page, required BuildContext context}) {
    Navigator.pushReplacement(
        context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  static push({required Widget page, required BuildContext context}) {
    Navigator.push(
        context, PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>  page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  static pushF({required Widget page, required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_)=>page),
        (route) => false);
  }
}
