import 'dart:math';

import 'package:flutter/material.dart';

//segment of the circle that represent one value
class Segment extends StatefulWidget {
  final double porcentaje;
  final double angInicio;
  final double height;
  final double width;
  final bool isBackground;

  const Segment({
    Key key,
    @required this.porcentaje,
    @required this.angInicio,
    this.height = 200,
    this.width = 200,
    this.isBackground = false,
  }) : super(key: key);

  @override
  _SegmentState createState() => _SegmentState();
}

class _SegmentState extends State<Segment> with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentajeAnterior;
  double angAnterior;
  List<Map<String, Object>> valoresAnteriores;
  final Color color =
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    angAnterior = widget.angInicio;

    controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);

    final diferenciaAnimarPorcentaje = widget.porcentaje - porcentajeAnterior;
    final diferenciaAnimarAngulo = widget.angInicio - angAnterior;

    porcentajeAnterior = widget.porcentaje;
    angAnterior = widget.angInicio;

    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: widget.height,
            width: widget.width,
            child: CustomPaint(
              painter: _CakeChartPainter(
                porcentaje: (widget.porcentaje - diferenciaAnimarPorcentaje) +
                    (diferenciaAnimarPorcentaje * controller.value),
                color: widget.isBackground ? Colors.grey[300] : color,
                angInicio: (widget.angInicio - diferenciaAnimarAngulo) +
                    (diferenciaAnimarAngulo * controller.value),
              ),
            ),
          );
        });
  }
}

class _CakeChartPainter extends CustomPainter {
  final Color color;
  final double porcentaje;
  final double angInicio;

  _CakeChartPainter({
    @required this.porcentaje,
    @required this.angInicio,
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final paint = new Paint()
      ..strokeWidth = 40
      ..color = color
      ..style = PaintingStyle.stroke;

    final center = new Offset(size.width * 0.5, size.height / 2);
    final radio = min(size.width * 0.5, size.height * 0.5);

    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), angInicio,
        arcAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
