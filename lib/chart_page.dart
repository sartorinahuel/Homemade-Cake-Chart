import 'dart:math';

import 'package:cake_chart/Cake%20Chart/cake_chart.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final List<Map<String, Object>> valores = [
    {
      "porcentaje": 40.0,
      "valor": "ss",
    },
    {
      "porcentaje": 18.0,
      "valor": "ss",
    },
    {
      "porcentaje": 12.0,
      "valor": "ss",
    },
    {
      "porcentaje": 30.0,
      "valor": "ss",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homemade Cake Chart")),
      body: Center(
        child: CakeChart(
          valores: valores,
          radio: 300,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Random random = new Random();
          final double randomNumber = random.nextDouble();
          final double randomNumber2 = random.nextDouble();
          final double randomNumber3 = random.nextDouble();
          final double primero = 100 * randomNumber;
          final double segundo = (100 - primero) * randomNumber2;
          final double tercero = (100 - primero - segundo) * randomNumber3;
          final double cuarto = 100 - primero - segundo - tercero;

          valores[0] = {
            "porcentaje": primero,
          };
          valores[1] = {
            "porcentaje": segundo,
          };
          valores[2] = {
            "porcentaje": tercero,
          };
          valores[3] = {
            "porcentaje": cuarto,
          };
          setState(() {});
        },
        child: Icon(Icons.replay),
      ),
    );
  }
}
