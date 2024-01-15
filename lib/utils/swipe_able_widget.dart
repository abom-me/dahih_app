import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../settings/sizes.dart';

class SwipeableWidget extends ConsumerStatefulWidget {
  final Widget child;
  final Function(DismissDirection) onDismissed;
  final List<Widget> actions;
  final double actionExtentRatio;
  final SwipeAbleController controller;

  const SwipeableWidget({super.key,
    required this.child,
    required this.controller,
    required this.onDismissed,
    this.actions = const [],

    required this.actionExtentRatio,
  });

  @override
  ConsumerState<SwipeableWidget> createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends ConsumerState<SwipeableWidget> {
  // ScrollController controller = ScrollController();
  // double _swipeOffset = 0.0;
  DismissDirection _dismissDirection = DismissDirection.startToEnd;
  // bool _actionsVisible = false;
  final hiddenWidgetKey = GlobalKey();
  final mainWidgetKey = GlobalKey();
  RenderBox? renderbox;

  SwipeAbleController controller2= SwipeAbleController();

getSizes() {
    

    controller2 = widget.controller;
    if (hiddenWidgetKey.currentContext != null) {
      final RenderObject? renderObject = hiddenWidgetKey.currentContext!.findRenderObject();
      if (renderObject is RenderBox) {
        renderbox = renderObject;
        setState(() {

        });
      }
    }

    controller2.addListener(() {

      setState(() {});
    });
  }
  @override
  void initState() {


    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSizes();
    });


  }

  @override
  Widget build(BuildContext context) {

    //

    return Stack(
alignment: Alignment.center,
      children: [
        AnimatedPositioned(

          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
          // height: 120,
          right:  controller2.actionsVisible?0:-100,
          // bottom: 0,
          // top: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity:  controller2.actionsVisible ? 1.0 : 0.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(

                  alignment: Alignment.center,
                  key: hiddenWidgetKey,
                  decoration:BoxDecoration(

                      borderRadius: BorderRadius.circular(10)
                  ),              child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.actions,
                ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){

          },
          onHorizontalDragStart: (details) {

              // _swipeOffset = 0.0;
              controller2.open();

          },
          onHorizontalDragUpdate: (details) {
            if(details.primaryDelta! < 0){

              controller2.setSwipeOffset((Sizes.width(context)*-0.29) *(renderbox!.size.width/110))  ;


                _dismissDirection = details.primaryDelta! > 0
                    ? DismissDirection.startToEnd
                    : DismissDirection.endToStart;

            }
            else{


                controller2.close();
                _dismissDirection = details.primaryDelta! > 0
                    ? DismissDirection.startToEnd
                    : DismissDirection.endToStart;

            }

          },
          onHorizontalDragEnd: (details) {
            if (controller2.swipeOffset.abs() > widget.actionExtentRatio) {
              widget.onDismissed(_dismissDirection);
            } else {

                controller2.close();
                // _actionsVisible = false;

            }
          },
          child: AnimatedContainer(
              key: mainWidgetKey,
            // margin: EdgeInsets.only(bottom: 5),

              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues( controller2.swipeOffset, 0, 0),
              child: widget.child
          ),
        ),


      ],
    );
  }
}

final swipeAbleControllerProvider = ChangeNotifierProvider<SwipeAbleController>((ref) => SwipeAbleController());
class SwipeAbleController  with ChangeNotifier{

  bool _actionsVisible = false;
  double _swipeOffset = 0.0;
  double get swipeOffset => _swipeOffset;
  bool get actionsVisible => _actionsVisible;
  set actionsVisible(bool value) {
    _actionsVisible = value;
    notifyListeners();
  }
  setSwipeOffset(double value) {
    _swipeOffset = value;
    notifyListeners();
  }

  close(){


  _actionsVisible = false;
  _swipeOffset = 0;
  notifyListeners();
}

  open(){

  _actionsVisible = true;

  notifyListeners();



  }


  @override
  void dispose() {
    _actionsVisible = false;
    _swipeOffset = 0;

    // TODO: implement dispose
    super.dispose();
  }


}