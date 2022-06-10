import 'package:flutter/material.dart';

void main() {
  runApp(AnimacoesMasterclass());
}

class AnimacoesMasterclass extends StatefulWidget {
  const AnimacoesMasterclass({Key? key}) : super(key: key);

  @override
  State<AnimacoesMasterclass> createState() => _AnimacoesMasterclassState();
}

class _AnimacoesMasterclassState extends State<AnimacoesMasterclass> {
  var isSelected = false;
  @override
  Widget build(BuildContext context) {
    const size = 200.0;

    return Material(
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),
            height: 80,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(80),
            ),
            child: AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
              alignment:
                  isSelected ? Alignment.bottomRight : Alignment.bottomLeft,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: 150,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.grey[700],
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Center(
                  child: isSelected
                      ? const Text(
                          'ON',
                          textDirection: TextDirection.ltr,
                        )
                      : const Text(
                          'OFF',
                          textDirection: TextDirection.ltr,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
