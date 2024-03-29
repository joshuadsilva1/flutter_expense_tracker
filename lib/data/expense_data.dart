
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/expense_item.dart';
import 'package:flutter_application_1/datetime/date_time_helper.dart';

class ExpenseData extends ChangeNotifier{

List<ExpenseItem> overallExpenseList = [];


List<ExpenseItem> getAllExpenseList(ExpenseItem newExpense){

return overallExpenseList;

}

void addNewExpense(ExpenseItem newExpense){
overallExpenseList.add(newExpense);

notifyListeners();
}

void deleteExpense(ExpenseItem expense){

  overallExpenseList.remove(expense);

}

String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thur';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';      
    case 7:
      return 'Sun';  
    default:
       return ''; 


  }


}


DateTime startOfWeekDate(){
  DateTime? startOfWeek;

  DateTime today = DateTime.now();


  for(int i=0;i<7;i++){
    if(getDayName(today.subtract(Duration(days:i)))=='Sun'){

      startOfWeek = today.subtract(Duration(days:i));

    }


  }

  return startOfWeek!;



}

Map<String, double> calculateDailyExpenseSummary(){

  Map<String, double> dailyExpenseSummary = {



  };

  for(var expense in overallExpenseList){

    String date = convertDateTimeToString(expense.dateTime);
    double amount = double.parse(expense.amount);

    if(dailyExpenseSummary.containsKey(date)){
      double currentAmmount = dailyExpenseSummary[date]!;
      currentAmmount += amount;
      dailyExpenseSummary[date] = currentAmmount;


    }else{


      dailyExpenseSummary.addAll({date: amount});

    }


  }

  return dailyExpenseSummary;


}




}