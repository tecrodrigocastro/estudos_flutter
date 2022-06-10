import 'package:flutter/material.dart';

class ImcView extends StatelessWidget {
  const ImcView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC/BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Peso',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Altura',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
