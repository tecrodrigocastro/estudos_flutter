import 'package:estudos/cases/animacoes/animacoes_impricitas.dart';
import 'package:estudos/cases/animacoes/animacoes_controladas.dart';
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
      home: const AnimacoesControladas(),
    );
  }
}
