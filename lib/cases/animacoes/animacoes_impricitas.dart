import 'package:flutter/material.dart';

class AnimacoesFlutter extends StatefulWidget {
  const AnimacoesFlutter({Key? key}) : super(key: key);

  @override
  State<AnimacoesFlutter> createState() => _AnimacoesFlutterState();
}

class _AnimacoesFlutterState extends State<AnimacoesFlutter> {
  var isLoading = true;
  double initial = 0.0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            isLoading = !isLoading;
          });
        },
        child: Text('Animar'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLoading = !isLoading;
            });
          },
          child: AnimatedContainer(
            alignment: Alignment.centerLeft,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 800),
            height: 80,
            width: 400,
            color: Colors.grey,
            child: AnimatedContainer(
              alignment: Alignment.center,
              curve: Curves.linear,
              duration: const Duration(seconds: 3),
              height: 80,
              width: isLoading ? initial : 400,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

Widget animacoes(bool isLoading) {
  return AnimatedCrossFade(
    duration: const Duration(milliseconds: 500),
    firstChild: const Padding(
      padding: EdgeInsets.all(20),
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
    secondChild: const Text(
      'Entrar',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    crossFadeState:
        isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
