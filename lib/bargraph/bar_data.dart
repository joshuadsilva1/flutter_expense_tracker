import 'package:flutter_application_1/bargraph/individual_bar.dart';

class BarData{

  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  

  BarData({

    required this.monAmount, 
    required this.tuesAmount, 
    required this.wedAmount, 
    required this.thurAmount, 
    required this.friAmount, 
    required this.satAmount, 
    required this.sunAmount, 
  });

  List<IndividualBar> barData = [];


  void initialBarData(){

barData = [


  IndividualBar(x: 0, y: sunAmount),

  IndividualBar(x: 1, y: monAmount),

  IndividualBar(x: 2, y: tuesAmount),

  IndividualBar(x: 3, y: wedAmount),


  IndividualBar(x: 4, y: thurAmount),


  IndividualBar(x: 5, y: friAmount),
  
  IndividualBar(x: 6, y: satAmount),
];

  }

}