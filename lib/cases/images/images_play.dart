import 'package:flutter/material.dart';

void main() {
  runApp(ImageDart());
}

class ImageDart extends StatelessWidget {
  const ImageDart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url = 'https://www.serebii.net/pokemongo/pokemon/001.png';
    return Material(
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(url.toString()),
          ),
        ),
      ),
    );
  }
}
