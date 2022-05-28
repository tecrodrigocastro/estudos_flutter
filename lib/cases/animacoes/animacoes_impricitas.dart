import 'package:flutter/material.dart';

class AnimacoesFlutter extends StatefulWidget {
  const AnimacoesFlutter({Key? key}) : super(key: key);

  @override
  State<AnimacoesFlutter> createState() => _AnimacoesFlutterState();
}

class _AnimacoesFlutterState extends State<AnimacoesFlutter> {
  var size = 100.0;
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLoading = !isLoading;
            });
          },
          child: AnimatedContainer(
              alignment: Alignment.center,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 800),
              height: 80,
              width: isLoading ? 80 : 400,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(isLoading ? 40 : 8)),
              child: AnimatedCrossFade(
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
                crossFadeState: isLoading
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              )),
        ),
      ),
    );
  }
}
