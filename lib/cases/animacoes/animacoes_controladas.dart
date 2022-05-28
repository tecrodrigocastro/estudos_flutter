import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnimacoesControladas extends StatefulWidget {
  const AnimacoesControladas({Key? key}) : super(key: key);

  @override
  State<AnimacoesControladas> createState() => _AnimacoesControladasState();
}

class _AnimacoesControladasState extends State<AnimacoesControladas>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> squadSize;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    squadSize = Tween<double>(begin: 100, end: 400).animate(controller);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (controller.value > 0) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: AnimatedBuilder(
              animation: squadSize,
              builder: (context, widget) {
                return Container(
                  height: squadSize.value,
                  width: squadSize.value,
                  color: Color.lerp(Colors.red, Colors.blue, controller.value),
                );
              }),
        ),
      ),
    );
  }
}
