

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bargraph/bar_graph.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child)=>SizedBox(
        height: 200,
        child: MyBarGraph(
           
          maxY: 100,
          sunAmount: 20,
          monAmount: 30,
          tuesAmount: 50,
          wedAmount: 40,
          thurAmount: 10,
          friAmount: 70,
          satAmount: 80,
          



        ),
      ),
      );
  }
}