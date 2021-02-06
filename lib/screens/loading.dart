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
  Timer _timer;
  double _progressVal = 0.0;

  @override
  void initState() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          updateProgress();
        },
      ),
    );

    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
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

  void updateProgress() {
    if (_progressVal == 1.0) {
      _progressVal = 0.1;
    } else {
      _progressVal += 0.2;
    }
  }
}
