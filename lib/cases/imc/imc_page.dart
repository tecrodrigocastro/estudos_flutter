import 'package:estudos/cases/imc/imc_controller.dart';
import 'package:estudos/cases/imc/imc_model.dart';
import 'package:flutter/material.dart';

class ImcView extends StatefulWidget {
  const ImcView({Key? key}) : super(key: key);

  @override
  State<ImcView> createState() => _ImcViewState();
}

class _ImcViewState extends State<ImcView> {
  final controller = ImcController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC/BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: controller.setWeigth,
              decoration: const InputDecoration(
                labelText: 'Peso',
              ),
            ),
            TextFormField(
              onChanged: controller.setHeigth,
              decoration: const InputDecoration(
                labelText: 'Altura',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  controller.calculateBMI();
                });
              },
              child: const Text('Calcular'),
            ),
            Text(controller.result),
          ],
        ),
      ),
    );
  }
}
