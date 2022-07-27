import 'package:flutter/material.dart';

class CadProduct extends StatefulWidget {
  const CadProduct({Key? key}) : super(key: key);

  @override
  State<CadProduct> createState() => _CadProductState();
}

class _CadProductState extends State<CadProduct> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Cadastrar Produto',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
