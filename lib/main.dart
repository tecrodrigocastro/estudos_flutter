import 'package:estudos/cases/animacoes/animacoes_controladas.dart';
import 'package:estudos/cases/animacoes/animacoes_impricitas.dart';
import 'package:estudos/cases/imc/imc_page.dart';
import 'package:estudos/cases/site/models/1/screens/home_screen.dart';
import 'package:estudos/cases/site/models/1/screens/responsive_study.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESTUDOS',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ResposiveCase(),
    );
  }
}
