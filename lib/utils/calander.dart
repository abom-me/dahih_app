import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:khlfan_shtain/utils/day_to_arabic.dart';

import '../settings/sizes.dart';

// class HorizontalCalendar extends StatefulWidget {
//    HorizontalCalendar({Key? key, required this.onSelected, required this.startDate, required this.size,this.events, required this.currentDateColor, required this.selectedDateColor, required this.dotEventsColor, required this.dateTextStyle, required this.years,
//   // required double size,
//   // required DateTime startDate,
//   // required int years,
//   }) : super(key: key);
//
//   final void Function(String dateString,String dayString, DateTime date) onSelected;
//
//   final int years;
//   final DateTime startDate;
//   final double size;
//   final List<String>? events;
//   final Color currentDateColor;
//   final Color selectedDateColor;
//   final Color dotEventsColor;
//   final TextStyle dateTextStyle;
//   @override
//   State<HorizontalCalendar> createState() => _HorizontalCalendarState();
// }
//
// class _HorizontalCalendarState extends State<HorizontalCalendar> {
//
//
//   final controller=ScrollController();
//
//   String currentDate=  formatDate(DateTime.now(), [mm,'/',dd]);
//   String fullCurrentDate=  formatDate(DateTime.now(), [yyyy,'/',mm,'/',dd]);
//   String selectedDate=  formatDate(DateTime.now(), [mm,'/',dd]);
//   String fullDate=  formatDate(DateTime.now(), [yyyy,'/',mm,'/',dd]);
//
//   List<Map<String,dynamic>> days = [];
//
//
//  getDaysInBetween() {
//  DateTime  startDate=widget.startDate;
//     for (int i = 0; i <= (widget.years*365); i++) {
//       days.add(
//         {
//           'dayString': formatDate(startDate.add(Duration(days: i)), [D]),
//           'dateString': formatDate(startDate.add(Duration(days: i)), [mm,'/',dd]),
//           'fullDateString': formatDate(startDate.add(Duration(days: i)), [yyyy,'/',mm,'/',dd]),
//           'date': startDate.add(Duration(days: i)),
//           'events': widget.events ?? ['0'],
//         }
//
//       );
//     }
//
//
//
//
//
//   }
//
//   scrollToIndex(date) {
//    var index=days.indexWhere((element) => element['dateString']==date)  ;
//
//     controller.animateTo( (widget.size+10)*index,
//         duration: const Duration(seconds: 1), curve: Curves.easeIn);
//   }
//   @override
//   void initState() {
//
//     getDaysInBetween();
//     Timer(const Duration(milliseconds: 1), () {
//       scrollToIndex(currentDate);
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(textDirection: TextDirection.ltr, child: SizedBox(
//         width: Sizes.width(context),
//         height: Sizes.height(context),
//         child: Column(
//           children: [
//             Text(fullDate),
//             SizedBox(
//               height: 90,
//               width: Sizes.width(context),
//               child: ListView.builder(
//                   controller: controller,
//                   scrollDirection: Axis.horizontal,
//                   // padding: EdgeInsets.all(20),
//                   itemCount:days.length,
//                   itemBuilder: (context,i){
//                     late   List<String> events=days[i]['events'];
//                     late   Iterable<String> event=events.where((element) => element==formatDate(days[i]['date'], [yyyy, '/', mm, '/', dd]));
//
//                     return InkWell(
//                       onDoubleTap: (){
//                         scrollToIndex(currentDate);
//                       },
//                       onTap: (){
//
//                         setState(() {
//                           selectedDate=days[i]['fullDateString'];
//                           fullDate=formatDate(days[i]['date'], [yyyy, '/', mm, '/', dd]);
//                           // scrollToIndex(selectedDate);
//                           widget.onSelected(days[i]['fullDateString'],days[i]['dayString'],days[i]['date']);
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Container(
//                               margin: const EdgeInsets.all(5),
//                               width: widget.size,
//                               height: widget.size,
//                               decoration:  BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: fullCurrentDate==days[i]['fullDateString']? widget.currentDateColor:selectedDate==days[i]['fullDateString']?widget.selectedDateColor:Colors.white,
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey.withOpacity(0.1),
//                                         blurRadius: 10,
//                                         offset: Offset(0,0)
//
//                                     )
//                                   ]
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(days[i]['dayString'].toString(),textAlign: TextAlign.center,style: widget.dateTextStyle,),
//                                   Text(days[i]['dateString'].toString(),textAlign: TextAlign.center,style: widget.dateTextStyle,),
//
//
//                                   event.isEmpty?SizedBox.shrink():Container(decoration: BoxDecoration(color: widget.dotEventsColor,borderRadius: BorderRadius.circular(100)),width: 8,height: 8,)
//                                 ],
//                               )
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         )));
//   }
// }


class HorizontalCalendar extends StatefulWidget {

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Horizontal Calendar widget allows you to show the Calendar as one line and you can scroll to show the days
  ///
  /// ### you can add action when the user click on any date
  ///
  /// ### you can see the full date on long press on any date
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// ### واجهة أفقية للتقويم تسمح لك بعرض التقويم كخط واحد ويمكنك التمرير لعرض الأيام
  ///
  /// ### يمكنك إضافة إجراء عندما ينقر المستخدم على أي تاريخ
  ///
  /// ### يمكنك رؤية التاريخ الكامل عند الضغط المطول على أي تاريخ
  ///
  const HorizontalCalendar({Key? key,
    required this.onSelected, required this.startDate, required this.size,this.events,  this.currentDateColor,  this.selectedDateColor,  this.dotEventsColor,  this.dateTextStyle, this.topDate,this.topDateTextStyle, required this.years, this.currentDateTextStyle,

  }) : super(key: key);

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Here you will get data after select date
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### هنا تظهر لك البيانات بعد أختيار التاريخ
  ///
  final void Function(String dateString,String dayString, DateTime date) onSelected;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Select How many years you want to show
  /// <span style="color:green;font-size:13;font-weight: bold;">should be years >=1  </span>
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### اكتب عدد السنوات التي تريد أظهارها في الشريط
  final int years;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Add start date here you should select where you want the calendar start
  /// <span style="color:green;font-size:13;font-weight: bold;">EX: DateTime(2023)</span>
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### هنا أختر تاريخ بدأ التقويم
  ///
  ///
  final DateTime startDate;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Here Size of the Square  as height and width
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### هنا حجم المربع الذي بداخله التاريخ ، الرقم يمثل الطول و العرض
  ///
  ///
  final double size;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Here Add The events dates to show The Red Dot under the event date in this format:
  /// <p style="color:red;font-size:10px;">Format[ 2023/02/25 ]</p>

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### هنا اضف تواريخ الفعاليات لكي يتم اضافة نقطة اسفل تاريخ الفعالية
  /// <p style="color:red;font-size:10px;">Format[ 2023/02/25 ]</p>
  ///
  final List<String>? events;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### The background of the current date box
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### لون خلفية مربع تاريخ اليوم
  ///
  ///
  final Color? currentDateColor;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### The background color for the selected box
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### لون خلفية التاريخ عند الضغط عليه
  ///
  ///
  final  Color? selectedDateColor;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### The color of the dot event is show under the event date
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### لون النقطة التي تظهر اسفل تاريخ الفعالية
  ///
  ///
  final Color? dotEventsColor;


  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ###  Date Text Style
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// #### تنسيق نص التاريخ
  ///
  ///
  final TextStyle? dateTextStyle;
  final TextStyle? currentDateTextStyle;
  final TextStyle? topDateTextStyle;
  final  bool? topDate;
  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {

  late bool topDate=widget.topDate??true;
  final controller=ScrollController();

  String currentDate=  formatDate(DateTime.now(), [mm,'/',dd]);
  String fullCurrentDate=  formatDate(DateTime.now(), [yyyy,'/',mm,'/',dd]);
  String selectedDate=  formatDate(DateTime.now(), [mm,'/',dd]);
  String fullDate=  formatDate(DateTime.now(), [yyyy,'/',mm,'/',dd]);

  List<Map<String,dynamic>> days = [];


  getDaysInBetween() {
    DateTime  startDate=widget.startDate;
    for (int i = 0; i <= (widget.years*365); i++) {
      days.add(
          {
            'dayString': formatDate(startDate.add(Duration(days: i)), [D]),
            'dateString': formatDate(startDate.add(Duration(days: i)), [mm,'/',dd]),
            'dayNumberString': formatDate(startDate.add(Duration(days: i)), [dd]),
            'fullDateString': formatDate(startDate.add(Duration(days: i)), [yyyy,'/',mm,'/',dd]),
            'date': startDate.add(Duration(days: i)),
            'events': widget.events ?? ['0'],
          }

      );
    }





  }

  scrollToIndex(date) {

    var index=days.indexWhere((element) => element['fullDateString']==date)  ;

    controller.animateTo( (widget.size+10)*index, duration: const Duration(milliseconds: 500), curve: Curves.linearToEaseOut);
  }
  @override
  void initState() {

    getDaysInBetween();
    Timer(const Duration(milliseconds: 1), () {
      scrollToIndex(fullCurrentDate);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.ltr, child: SizedBox(
        width: Sizes.width(context),
        height: Sizes.height(context),
        child: Column(
          children: [
            // topDate?    Container( margin:const EdgeInsets.symmetric(vertical: 5),child: Text(fullDate,style: widget.topDateTextStyle,)):const SizedBox.shrink(),
            SizedBox(
              height: 130,
              width: Sizes.width(context),
              child: ListView.builder(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  // padding: EdgeInsets.all(20),
                  itemCount:days.length,
                  itemBuilder: (context,i){
                    late   List<String> events=days[i]['events'];
                    late   Iterable<String> event=events.where((element) => element==formatDate(days[i]['date'], [yyyy, '/', mm, '/', dd]));

                    return InkWell(
                      focusColor: Colors.transparent,
                      highlightColor:Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onDoubleTap: (){

                        scrollToIndex(fullCurrentDate);
                      },
                      onTap: (){
                        // print(days[i]);
                        setState(() {
                          selectedDate=days[i]['fullDateString'];
                          fullDate=formatDate(days[i]['date'], [yyyy, '/', mm, '/', dd]);
                          // scrollToIndex(selectedDate);
                          widget.onSelected(days[i]['fullDateString'],days[i]['dayString'],days[i]['date']);
                        });
                      },
                      child: Tooltip(
                        message: days[i]['fullDateString'],
                        child: Column(
                          children: [
                            AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                margin: const EdgeInsets.all(5),
                                width: 60,
                                height: 120,
                                decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: fullCurrentDate==days[i]['fullDateString']? widget.currentDateColor??Theme.of(context).colorScheme.primary:selectedDate==days[i]['fullDateString']?widget.selectedDateColor??Colors.black45:Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0,0)

                                      )
                                    ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Text(days[i]['dayNumberString'].toString(),textAlign: TextAlign.center,style:fullCurrentDate==days[i]['fullDateString']?widget.currentDateTextStyle: widget.dateTextStyle,),

                                    Text(days[i]['dayString'].toString().shortDayToArabic,textAlign: TextAlign.center,style: fullCurrentDate==days[i]['fullDateString']?widget.currentDateTextStyle?.copyWith(fontSize: 15): widget.dateTextStyle?.copyWith(fontSize: 15),),

                                    event.isEmpty?const SizedBox.shrink():Container(decoration: BoxDecoration(color: widget.dotEventsColor??Colors.red.withOpacity(0.5),borderRadius: BorderRadius.circular(100)),width: 5,height: 5,)
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )));
  }
}



