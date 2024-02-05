import 'package:flutter/material.dart';



class MainButton extends StatelessWidget {
  const MainButton({required this.text,required this.width,required this.height,required this.onPressed,super.key});
final double width;
final double height;
final String text;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor:Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}




class SecButton extends StatelessWidget {
  const SecButton({required this.text,required this.width,required this.height,required this.onPressed,super.key});
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [

          ]),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              // shadowColor:Theme.of(context).colorScheme.secondary,
              // backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 17,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
