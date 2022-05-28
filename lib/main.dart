import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:printer/printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _printResult = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await Printer.platformVersion ?? 'Unknown platform version';
      String content = "     *NEPAL TOURISM*     \n" +
          "Date : 04/05/2022        \n" +
          "Date  :        04/05/2022\n" +
          "Time  :          05:32 PM\n" +
          "Bus No:       UP-14AZ1512\n" +
          "  Delhi   to   Ghazibad  \n" +
          "Adult (2 X 100) =  200.00\n" +
          "Child (1 X 50)  =   50.00\n" +
          "     Total    250.00     \n" +
          "      *SHUB YATRA*       ";

      _printResult = await Printer.printContent(content: content) ??
          'Unknown platform version';
      //_printResult = await Printer.printImage(imageBitmap) ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(
              'Running on: $_platformVersion\nPrint Result: $_printResult'),
        ),
      ),
    );
  }
}
