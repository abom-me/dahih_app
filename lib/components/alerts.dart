import 'dart:async';

import 'package:flutter/material.dart';

import '../auto_local/lang.dart';
import '../settings/sizes.dart';




class Alert {
  static msg(context, title, msg, {bool? action,GestureTapCallback? onOk, GestureTapCallback? onCancel}) {
    return showDialog(
      context: context,
      builder: (ctx) => Stack(
        children: [
          AlertDialog(
            scrollable: true,
            elevation: 0,
            // backgroundColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            content: Container(
              alignment: Alignment.center,

              width: Sizes.width(context),

              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 17,
                                fontWeight: FontWeight.w900),
                          ),
                          BoxSize.height(10),
                          Text(
                            msg,
                            style: const TextStyle(
                                // color: Theme.of(context).colorScheme.secondary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          width: Sizes.width(context),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed:action==true?onOk: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text(
                              Lang.get(context, key: LangKey.ok),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      if(action==true) Expanded(
                        child: Container(
                          width: Sizes.width(context),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed:onCancel,
                            child: Text(
                              Lang.get(context, key: LangKey.cancel),
                              style:  TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 17, color: Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static loading(context, title ,{bool? ableToClose=true}) {
    showDialog(
      context: context,
      barrierDismissible: ableToClose??false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          // backgroundColor: Colors.white,
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // LoadingAnimationWidget.beat(color: purpleColor, size: 20),
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  static snackbar(context, {required String text, bool? isFloating = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        behavior: isFloating == true ? SnackBarBehavior.floating : null,
        // backgroundColor: purpleColor,
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700),
        )));
  }

  Widget? snackbar2(context, {required String text, bool? isFloating = false}) {
    bool show=true;
    Timer(const Duration(seconds: 5), () {
      show=false;
    });

    if(show){
      return Container(
        height: 100,
        width: 100,
        color: Colors.green,
      );
    }
    return null;
  }
  static popup(context,
      {required Widget widget,
      EdgeInsetsGeometry? padding,
      MainAxisAlignment? main}) {
   return showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           elevation: 0,
           backgroundColor: Colors.white,
           content: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 padding: padding ??
                     const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10)),
                 // width: Sizes.width(context)*0.9,

                 child: widget,
               )
             ],
           ),
         );
       });
  }

  static close(context){
    Navigator.of(context).pop();
  }
}
