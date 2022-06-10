import 'dart:async';

import 'package:estudos/app/utils/schema_colors.dart';
import 'package:estudos/app/views/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void isLoading() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: (BuildContext context, _, __) {
                  return Center(child: Text('My PageRoute'));
                },
                transitionsBuilder:
                    (___, Animation<double> animation, ____, Widget child) {
                  return FadeTransition(
                    opacity: animation,
                    child: RotationTransition(
                      turns: Tween<double>(begin: 0.5, end: 1.0)
                          .animate(animation),
                      child: child,
                    ),
                  );
                }));
      },
    );
  }

  void initState() {
    super.initState();
    isLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Image.asset(
          'images/masterclass_logo.png',
        ),
      ),
    );
  }
}
