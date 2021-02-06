import 'dart:async';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  AnimationController animationController;
  double _progressVal = 0.0;

  @override
  void initState() {
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: animationController
                .drive(ColorTween(begin: Colors.blueAccent, end: Colors.red)),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progressVal == 1.0) {
            _progressVal = 0.1;
            //timer.cancel();
          } else {
            _progressVal += 0.2;
          }
        },
      ),
    );
  }
}
