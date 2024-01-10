import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../settings/sizes.dart';

class SwipeableWidget extends StatefulWidget {
  final Widget child;
  final Function(DismissDirection) onDismissed;
  final List<Widget> actions;
  final double actionExtentRatio;

  const SwipeableWidget({
    required this.child,
    required this.onDismissed,
    this.actions = const [],
    required this.actionExtentRatio,
  });

  @override
  State<SwipeableWidget> createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> {
  double _swipeOffset = 0.0;
  DismissDirection _dismissDirection = DismissDirection.startToEnd;
  bool _actionsVisible = false;
  final mywidgetkey = GlobalKey();
  RenderBox? renderbox;

  getSizes() {
    if (mywidgetkey.currentContext != null) {
      final RenderObject? renderObject = mywidgetkey.currentContext!.findRenderObject();
      if (renderObject is RenderBox) {
        renderbox = renderObject;
        setState(() {

        });
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getSizes();
    });


  }
  @override
  Widget build(BuildContext context) {

    //

    return Stack(
      children: [
        AnimatedPositioned(

          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
          height: 120,
          right: _actionsVisible?0:-100,
          // bottom: 0,
          // top: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: _actionsVisible ? 1.0 : 0.0,
              child: Container(
                key: mywidgetkey,
                decoration:BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                ),              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.actions,
              ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){

          },
          onHorizontalDragStart: (details) {
            setState(() {
              // _swipeOffset = 0.0;
              _actionsVisible = true;
            });
          },
          onHorizontalDragUpdate: (details) {
            if(details.primaryDelta! < 0){
              setState(() {
                _swipeOffset = (Sizes.width(context)*-0.29) *(renderbox!.size.width/110) ;


                _dismissDirection = details.primaryDelta! > 0
                    ? DismissDirection.startToEnd
                    : DismissDirection.endToStart;
              });
            }
            else{
              setState(() {
                _swipeOffset = 0 ;
                _actionsVisible = false;
                _dismissDirection = details.primaryDelta! > 0
                    ? DismissDirection.startToEnd
                    : DismissDirection.endToStart;
              });
            }

          },
          onHorizontalDragEnd: (details) {
            if (_swipeOffset.abs() > widget.actionExtentRatio) { // Use widget.actionExtentRatio
              widget.onDismissed(_dismissDirection);
            } else {
              setState(() {
                _swipeOffset = 0.0;
                // _actionsVisible = false;
              });
            }
          },
          child: AnimatedContainer(
            // margin: EdgeInsets.only(bottom: 5),

              duration: Duration(milliseconds: 100),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues( _swipeOffset, 0, 0),
              child: widget.child
          ),
        ),


      ],
    );
  }
}