import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';


bool _isShowing = false;
bool _barrierDismissible = true, _showLogs = false;

double _borderRadius = 8.0;
Color _backgroundColor = Colors.transparent;
Curve _insetAnimCurve = Curves.easeInOut;

// Widget _progressWidget = Lottie.asset(Assets.assetsLoader,width: 100,height: 100);
Widget _progressWidget = CircularProgressIndicator(
  color: Colors.red,
);

class ProgressDialog {
  late _Body _dialog;

  ProgressDialog({bool isDismissible = false, bool showLogs = false}) {
    _barrierDismissible = true;
    _showLogs = showLogs;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> dismiss() {
    if (_isShowing) {
      try {
        _isShowing = false;
        Get.back();
        if (_showLogs) debugPrint('ProgressDialog dismissed');
        return Future.value(true);
      } catch (_) {
        return Future.value(false);
      }
    } else {
      if (_showLogs) debugPrint('ProgressDialog already dismissed');
      return Future.value(false);
    }
  }

  void show() {
    if (!_isShowing) {
      _dialog = _Body();
      _isShowing = true;
      if (_showLogs) debugPrint('ProgressDialog shown');
      Get.dialog(
        Material(
          type: MaterialType.transparency,
          child: WillPopScope(
            onWillPop: () {
              return Future.value(_barrierDismissible);
            },
            child: Dialog(
                backgroundColor: _backgroundColor,
                insetAnimationCurve: _insetAnimCurve,
                insetAnimationDuration: const Duration(milliseconds: 100),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(_borderRadius))),
                child: _dialog),
          ),
        ),
        barrierDismissible: false,
      );
    } else {
      if (_showLogs) debugPrint("ProgressDialog already shown/showing");
    }
  }
}

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  final _BodyState _dialog = _BodyState();

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _BodyState extends State<_Body> {
  @override
  void dispose() {
    _isShowing = false;
    if (_showLogs) debugPrint('ProgressDialog dismissed by back button');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var padding = width / 15;
    var margin = width / 4;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      child: _progressWidget,
    );
  }
}