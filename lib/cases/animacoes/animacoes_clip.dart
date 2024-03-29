import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const light = Color(0xffead481);
const textLight = Color.fromARGB(255, 173, 162, 118);
const lightBack = Color.fromARGB(255, 205, 197, 163);
const background = Color.fromARGB(255, 15, 11, 2);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: background,
        body: Center(child: LightbuldDemo()),
      ),
    );
  }
}

class LightbuldDemo extends StatefulWidget {
  const LightbuldDemo({Key? key}) : super(key: key);

  @override
  State<LightbuldDemo> createState() => _LightbuldDemoState();
}

const double _length = 200;

class _LightbuldDemoState extends State<LightbuldDemo>
    with SingleTickerProviderStateMixin {
  late final _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));

  final Tween<double> tween = Tween(begin: -pi / 9, end: pi / 9);
  late final Animation<double> animation = tween.animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

  bool _onSwitch = false;

  void _toggle() {
    setState(() {
      _onSwitch = !_onSwitch;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static const constraintDefault = 800.0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth > constraintDefault)
            ? constraintDefault
            : constraints.maxWidth;
        final height = constraints.maxHeight;
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final dx = sin(animation.value) * _length;
            final dy = cos(animation.value) * _length;

            final alignX = ui.lerpDouble(-1.0, 1.0, dx / width)!;
            final alignY = ui.lerpDouble(-1.0, 1.0, dy / height)!;
            final alignment = Alignment(
              alignX,
              alignY,
            );

            final content = Align(
              alignment: Alignment.topCenter,
              child: TextContent(on: _onSwitch),
            );

            return Stack(
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: constraintDefault),
                    child: CustomPaint(
                      foregroundPainter: LightBulbPainter(
                        offset: Offset(dx, dy),
                        angle: animation.value,
                        on: _onSwitch,
                      ),
                      child: !_onSwitch
                          ? content
                          : ShaderMask(
                              shaderCallback: (bounds) {
                                return RadialGradient(
                                  center: alignment,
                                  radius: 1.1,
                                  colors: [
                                    textLight,
                                    lightBack.withOpacity(0.8),
                                    lightBack.withOpacity(0.4),
                                    lightBack.withOpacity(0.2),
                                  ],
                                  stops: const [
                                    0,
                                    0.5,
                                    0.6,
                                    0.9,
                                  ],
                                ).createShader(bounds);
                              },
                              child: content,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  left: dx + ((constraints.maxWidth - 800) / 2) - 25,
                  top: dy,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        _toggle();
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({
    Key? key,
    required this.on,
  }) : super(key: key);

  final bool on;

  @override
  Widget build(BuildContext context) {
    final color = on ? Colors.white : Colors.white.withAlpha(10);
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Human Interface Guidelines: The Apple Desktop Interface',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: color, shadows: [const Shadow(color: Colors.black)]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Metaphors from the real world',
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(color: color),
            ),
          ),
          Text(
            textValue,
            style: TextStyle(color: color, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class LightBulbPainter extends CustomPainter {
  final Offset offset;
  final double angle;
  final bool on;

  LightBulbPainter({
    required this.offset,
    required this.angle,
    required this.on,
  });

  final lightbulbPaint = Paint()..color = Colors.yellow;

  late final transformMatrix = Matrix4.identity()
    ..translate(offset.dx - 25, offset.dy - 3 + angle * 12)
    ..rotateZ(-angle * 0.5);

  @override
  void paint(Canvas canvas, Size size) {
    paintLightbulb(canvas, const Size(50, 50));
    if (!on) return;
    final shaderPaint = Paint()
      ..shader = ui.Gradient.radial(
        offset + const Offset(0, 25), // center
        600, // radius
        [
          light.withAlpha(200),
          light.withAlpha(120),
          light.withAlpha(70),
          light.withAlpha(60),
          lightBack.withAlpha(50),
          lightBack.withAlpha(15),
          lightBack.withOpacity(0.05),
          Colors.transparent
        ], // colors
        [0, 0.07, 0.15, 0.2, 0.26, 0.35, 0.4, 0.75],
      );
    canvas.drawPaint(shaderPaint);

    final path = Path();
    path.moveTo(offset.dx, offset.dy);

    canvas.drawPath(path, Paint()..color = Colors.black);
  }

  void paintLightbulb(Canvas canvas, Size size) {
    final linePath = Path();
    linePath.moveTo(0, -20);
    linePath.lineTo(offset.dx, offset.dy);

    canvas.drawPath(
        linePath,
        Paint()
          ..color = Colors.black.withAlpha(120)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6);
    canvas.drawPath(
      linePath,
      Paint()
        ..color = on ? Colors.grey.withAlpha(100) : Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1860352, size.height * 0.6772461);
    path_0.cubicTo(
        size.width * 0.1860352,
        size.height * 0.8505859,
        size.width * 0.3265625,
        size.height * 0.9925781,
        size.width * 0.5000000,
        size.height * 0.9925781);
    path_0.cubicTo(
        size.width * 0.6734375,
        size.height * 0.9925781,
        size.width * 0.8139648,
        size.height * 0.8505859,
        size.width * 0.8139648,
        size.height * 0.6772461);
    path_0.cubicTo(
        size.width * 0.8139648,
        size.height * 0.6085938,
        size.width * 0.7775391,
        size.height * 0.5200195,
        size.width * 0.7190430,
        size.height * 0.4546875);
    path_0.cubicTo(
        size.width * 0.6610352,
        size.height * 0.3899414,
        size.width * 0.6179687,
        size.height * 0.2809570,
        size.width * 0.6179687,
        size.height * 0.1940430);
    path_0.lineTo(size.width * 0.6179687, size.height * 0.1599609);
    path_0.lineTo(size.width * 0.3820312, size.height * 0.1599609);
    path_0.lineTo(size.width * 0.3820312, size.height * 0.1937500);
    path_0.cubicTo(
        size.width * 0.3820312,
        size.height * 0.2806641,
        size.width * 0.3389648,
        size.height * 0.3894531,
        size.width * 0.2812500,
        size.height * 0.4543945);
    path_0.cubicTo(
        size.width * 0.2225586,
        size.height * 0.5204102,
        size.width * 0.1860352,
        size.height * 0.6168945,
        size.width * 0.1860352,
        size.height * 0.6772461);
    path_0.lineTo(size.width * 0.1860352, size.height * 0.6772461);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = on
        ? const Color(0xffFFC807).withOpacity(1.0)
        : Colors.white.withAlpha(200);
    canvas.drawPath(path_0.transform(transformMatrix.storage), paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3784180, size.height * 0.2279297);
    path_1.lineTo(size.width * 0.5677734, size.height * 0.4896484);
    path_1.lineTo(size.width * 0.4175781, size.height * 0.8027344);
    path_1.lineTo(size.width * 0.2230469, size.height * 0.5425781);
    path_1.cubicTo(
        size.width * 0.2400391,
        size.height * 0.5070313,
        size.width * 0.2614258,
        size.height * 0.4767578,
        size.width * 0.2854492,
        size.height * 0.4496094);
    path_1.cubicTo(
        size.width * 0.3307617,
        size.height * 0.3935547,
        size.width * 0.3514648,
        size.height * 0.3446289,
        size.width * 0.3710938,
        size.height * 0.2763672);
    path_1.lineTo(size.width * 0.3784180, size.height * 0.2279297);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = on
        ? const Color(0xffFFB300).withOpacity(1.0)
        : Colors.white.withOpacity(0.4);
    canvas.drawPath(path_1.transform(transformMatrix.storage), paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5122070, size.height * 0.6305664);
    path_2.lineTo(size.width * 0.5929688, size.height * 0.6305664);
    path_2.cubicTo(
        size.width * 0.6052734,
        size.height * 0.6305664,
        size.width * 0.6138672,
        size.height * 0.6429687,
        size.width * 0.6093750,
        size.height * 0.6544922);
    path_2.lineTo(size.width * 0.5515625, size.height * 0.8039063);
    path_2.cubicTo(
        size.width * 0.5489258,
        size.height * 0.8106445,
        size.width * 0.5423828,
        size.height * 0.8151367,
        size.width * 0.5351563,
        size.height * 0.8151367);
    path_2.lineTo(size.width * 0.4326172, size.height * 0.8151367);
    path_2.cubicTo(
        size.width * 0.4193359,
        size.height * 0.8151367,
        size.width * 0.4108398,
        size.height * 0.8009766,
        size.width * 0.4170898,
        size.height * 0.7892578);
    path_2.lineTo(size.width * 0.4966797, size.height * 0.6398438);
    path_2.cubicTo(
        size.width * 0.4998047,
        size.height * 0.6341797,
        size.width * 0.5057617,
        size.height * 0.6305664,
        size.width * 0.5122070,
        size.height * 0.6305664);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color =
        on ? const Color(0xffFFF8E1).withOpacity(1.0) : Colors.yellow.shade100;
    canvas.drawPath(path_2.transform(transformMatrix.storage), paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.5447266, size.height * 0.4938477);
    path_3.lineTo(size.width * 0.3884766, size.height * 0.6608398);
    path_3.cubicTo(
        size.width * 0.3767578,
        size.height * 0.6733398,
        size.width * 0.3856445,
        size.height * 0.6937500,
        size.width * 0.4027344,
        size.height * 0.6937500);
    path_3.lineTo(size.width * 0.5052734, size.height * 0.6937500);
    path_3.cubicTo(
        size.width * 0.5137695,
        size.height * 0.6937500,
        size.width * 0.5212891,
        size.height * 0.6882812,
        size.width * 0.5239258,
        size.height * 0.6801758);
    path_3.lineTo(size.width * 0.5776367, size.height * 0.5131836);
    path_3.cubicTo(
        size.width * 0.5840820,
        size.height * 0.4932617,
        size.width * 0.5589844,
        size.height * 0.4785156,
        size.width * 0.5447266,
        size.height * 0.4938477);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xffFFF8E1).withOpacity(1.0);
    canvas.drawPath(path_3.transform(transformMatrix.storage), paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4203125, size.height * 0.007421836);
    path_4.lineTo(size.width * 0.5796875, size.height * 0.007421846);
    path_4.cubicTo(
        size.width * 0.5852539,
        size.height * 0.007421846,
        size.width * 0.5903320,
        size.height * 0.01103516,
        size.width * 0.5933594,
        size.height * 0.01699219);
    path_4.lineTo(size.width * 0.6150391, size.height * 0.06015625);
    path_4.lineTo(size.width * 0.3849609, size.height * 0.06015625);
    path_4.lineTo(size.width * 0.4066406, size.height * 0.01699219);
    path_4.cubicTo(
        size.width * 0.4096680,
        size.height * 0.01103516,
        size.width * 0.4147461,
        size.height * 0.007421836,
        size.width * 0.4203125,
        size.height * 0.007421836);
    path_4.lineTo(size.width * 0.4203125, size.height * 0.007421836);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff455A64).withOpacity(1.0);
    canvas.drawPath(path_4.transform(transformMatrix.storage), paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3889648, size.height * 0.04257813);
    path_5.lineTo(size.width * 0.6110352, size.height * 0.04257813);
    path_5.cubicTo(
        size.width * 0.6326172,
        size.height * 0.04257813,
        size.width * 0.6501953,
        size.height * 0.06005859,
        size.width * 0.6501953,
        size.height * 0.08173828);
    path_5.lineTo(size.width * 0.6501953, size.height * 0.2415039);
    path_5.cubicTo(
        size.width * 0.6501953,
        size.height * 0.2630859,
        size.width * 0.6327148,
        size.height * 0.2806641,
        size.width * 0.6110352,
        size.height * 0.2806641);
    path_5.lineTo(size.width * 0.3888672, size.height * 0.2806641);
    path_5.cubicTo(
        size.width * 0.3672852,
        size.height * 0.2806641,
        size.width * 0.3497070,
        size.height * 0.2631836,
        size.width * 0.3497070,
        size.height * 0.2415039);
    path_5.lineTo(size.width * 0.3497070, size.height * 0.08164053);
    path_5.cubicTo(
        size.width * 0.3498047,
        size.height * 0.06005850,
        size.width * 0.3672852,
        size.height * 0.04257813,
        size.width * 0.3889648,
        size.height * 0.04257813);
    path_5.lineTo(size.width * 0.3889648, size.height * 0.04257813);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xffECEFF1).withOpacity(1.0);
    canvas.drawPath(path_5.transform(transformMatrix.storage), paint5Fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.4728516, size.height * 0.2103516);
    path_6.lineTo(size.width * 0.6494141, size.height * 0.2103516);
    path_6.lineTo(size.width * 0.6494141, size.height * 0.2455078);
    path_6.lineTo(size.width * 0.4728516, size.height * 0.2455078);
    path_6.cubicTo(
        size.width * 0.4631836,
        size.height * 0.2455078,
        size.width * 0.4552734,
        size.height * 0.2375977,
        size.width * 0.4552734,
        size.height * 0.2279297);
    path_6.cubicTo(
        size.width * 0.4552734,
        size.height * 0.2181641,
        size.width * 0.4631836,
        size.height * 0.2103516,
        size.width * 0.4728516,
        size.height * 0.2103516);
    path_6.close();
    path_6.moveTo(size.width * 0.6494141, size.height * 0.1795898);
    path_6.lineTo(size.width * 0.3505859, size.height * 0.1795898);
    path_6.lineTo(size.width * 0.3505859, size.height * 0.1444336);
    path_6.lineTo(size.width * 0.6494141, size.height * 0.1444336);
    path_6.lineTo(size.width * 0.6494141, size.height * 0.1795898);
    path_6.close();
    path_6.moveTo(size.width * 0.3505859, size.height * 0.07851563);
    path_6.lineTo(size.width * 0.5167969, size.height * 0.07851563);
    path_6.cubicTo(
        size.width * 0.5264648,
        size.height * 0.07851563,
        size.width * 0.5343750,
        size.height * 0.08642578,
        size.width * 0.5343750,
        size.height * 0.09609375);
    path_6.cubicTo(
        size.width * 0.5343750,
        size.height * 0.1057617,
        size.width * 0.5264648,
        size.height * 0.1136719,
        size.width * 0.5167969,
        size.height * 0.1136719);
    path_6.lineTo(size.width * 0.3505859, size.height * 0.1136719);
    path_6.lineTo(size.width * 0.3505859, size.height * 0.07851563);
    path_6.close();

    Paint paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = const Color(0xffCFD8DC).withOpacity(1.0);
    canvas.drawPath(path_6.transform(transformMatrix.storage), paint6Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

const textValue =
    '''People use Apple’s accessibility features to personalize how they interact with their devices in ways that work for them.
                
An accessible app or game supports accessibility personalizations by design and gives everyone a great user experience, regardless of their capabilities or how they use their devices.
                
Approximately one in seven people have a disability that affects the way they interact with the world and their devices. People can experience disabilities at any age, for any duration, and at varying levels of severity. For example, situational disabilities — such as a wrist injury from a fall or voice loss from overuse — can affect the way almost everyone interacts with their devices at various times.
                
Design with accessibility in mind. Accessibility is not just about making information available to people with disabilities — it’s about making information available to everyone, regardless of their capabilities or situation.

Designing your app with accessibility in mind means prioritizing simplicity and perceivability and examining every design decision to ensure that it doesn’t exclude people who have different abilities or interact with their devices in different ways.

“Apple embeds accessibility into every aspect of our work, and we are committed to designing the best products and services for everyone,” said Sarah Herrlinger, Apple’s senior director of Accessibility Policy and Initiatives. “We’re excited to introduce these new features, which combine innovation and creativity from teams across Apple to give users more options to use our products in ways that best suit their needs and lives.”''';
