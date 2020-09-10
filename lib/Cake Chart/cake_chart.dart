import 'dart:math';

import 'package:cake_chart/Cake%20Chart/segment.dart';
import 'package:flutter/material.dart';

class CakeChart extends StatelessWidget {
  final List<Map<String, Object>> valores;
  final double radio;

  const CakeChart({
    @required this.valores,
    this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
              height: radio,
              width: radio,
              child: Segment(
                porcentaje: 100,
                angInicio: -pi / 2,
                isBackground: true,
              )),
          if (valores.length != null) ..._graph(valores, radio, radio),
        ],
      ),
    );
  }
}

List<Widget> _graph(
    List<Map<String, Object>> valores, double height, double width) {
  final List<Widget> circulo = [];
  double angInicio = -pi / 2;

  if (valores.length == 0) {
    circulo.add(
      Container(
        height: 1,
        width: 1,
      ),
    );
    return circulo;
  }

  for (int i = 0; i < valores.length; i++) {
    double porc = valores[i]["porcentaje"];

    final w = Segment(
      porcentaje: porc,
      angInicio: angInicio,
      height: height,
      width: width,
    );

    circulo.add(w);

    angInicio = angInicio + (porc / 100) * (2 * pi);
  }

  return circulo;
}
