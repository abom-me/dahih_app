// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:khlfan_shtain/settings/sizes.dart';
//
// class SwipeForMore extends StatefulWidget {
//   @override
//   _SwipeForMoreState createState() => _SwipeForMoreState();
// }
//
// class _SwipeForMoreState extends State<SwipeForMore> {
//   List<String> items = List.generate(10, (index) => 'Item ${index + 1}');
//   bool isSwiped = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Swipe for More'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return SwipeableWidget(onDismissed: (DismissDirection ) {  },
//           actionExtentRatio: 0.25,
//               actions: [
//                 Icon(Icons.delete,color: Colors.redAccent,),
//                 Icon(Icons.delete),
//                 Icon(Icons.delete),
//                 Icon(Icons.delete),
//                 Icon(Icons.delete),
//               ],
//           child: SizedBox(
//             width: Sizes.width(context),
//             child: ListTile(
//               title: Text(items[index]),
//             ),
//           ));
//         },
//       ),
//     );
//   }
// }
//
//
