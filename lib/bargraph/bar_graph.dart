import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bargraph/bar_data.dart';

class MyBarGraph extends StatelessWidget {
 final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph({
    super.key,
    required this.maxY,
     required this.monAmount, 
    required this.tuesAmount, 
    required this.wedAmount, 
    required this.thurAmount, 
    required this.friAmount, 
    required this.satAmount, 
    required this.sunAmount,

  });
  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(monAmount: monAmount, tuesAmount: tuesAmount, wedAmount: wedAmount, thurAmount: thurAmount, friAmount: friAmount, satAmount: satAmount, sunAmount: sunAmount);
    myBarData.initialBarData();
    return BarChart(BarChartData(
      maxY: 100,
      minY: 0,
      barGroups: myBarData.barData
      .map(
        (data)=>BarChartGroupData(
          x : data.x,
          barRods: [
            BarChartRodData(toY: data.y,),
          ]
        ),
        )
        .toList()
    ));
    
    }

}
 