import 'dart:async';

import 'package:flutter/material.dart';

import '../../settings/sizes.dart';


class NewSheetButtons extends StatefulWidget {
  const NewSheetButtons({super.key, required this.text, required this.icon, required this.onTap, required this.duration});
final String text;
final IconData icon;
final Function onTap;
final Duration duration;
  @override
  State<NewSheetButtons> createState() => _NewSheetButtonsState();
}

class _NewSheetButtonsState extends State<NewSheetButtons> {
  bool start = false;
  @override
  void initState() {
   Timer(const Duration(milliseconds: 100), (){
     setState(() {
       start = true;
     });
    });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
       return InkWell(
      onTap: () => widget.onTap(),
      child: AnimatedContainer(
        curve: Curves.easeOut,
        transform: Matrix4.translationValues( start?0:-500, 0, 0),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        width: Sizes.width(context),
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background.withOpacity(0.2),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        duration: widget.duration,
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).colorScheme.primary,
              size: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),


      ),
    );
  }
}
