import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/expense_summary.dart';
import 'package:flutter_application_1/data/expense_data.dart';
import 'package:flutter_application_1/models/expense_item.dart';
import 'package:flutter_application_1/screens/expense_model.dart';
import 'package:flutter_application_1/screens/item.dart';
import 'package:flutter_application_1/screens/fund_condition_widget.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

List options = ["expense", "income"];
List<ExpenseModel> expenses = [];

class HomeScreenState extends State<HomeScreen> {

  void addNewExpense() {


  
            showDialog(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: 400,
                  child: AlertDialog(
                    title: const Padding(
                      padding: EdgeInsets.only(left: 1.6),
                      child: Text("ADD TRANSACTION"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          amount = int.parse(amountController.text);
                          // adding a new item
                          final expense = ExpenseModel(
                            item: itemController.text,
                            amount: amount,
                            isIncome: currentOption == "income" ? true : false,
                            date: pickedDate!,
                          );
                          expenses.add(expense);
                          if (expense.isIncome) {
                           
                         
                            setState(() {});
                          } else if (!expense.isIncome) {
                            spentMoney += expense.amount;
                          
                            setState(() {});
                          }

                          itemController.clear();
                          amountController.clear();
                          dateController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "ADD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                    content: SizedBox(
                      height: 340,
                      width: 400,
                      child: Column(
                      
                        children: [
                          TextField(
                            controller: itemController,
                            decoration: const InputDecoration(
                              hintText: "Enter the Item",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Enter the Amount",
                              hintStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              onTap: () async {
                                // user can pick date
                                pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                String date =
                                    DateFormat.yMMMMd().format(pickedDate!);
                                dateController.text = date;
                                setState(() {});
                              },
                              controller: dateController,
                              decoration: const InputDecoration(
                                labelText: "DATE",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 44, 51, 55),
                                ),
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                prefixIconColor: Colors.blue,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(height: 15),
                          RadioMenuButton(
                            value: options[0],
                            groupValue: currentOption,
                            onChanged: (expense) {
                              currentOption = expense.toString();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.4,
                                ),
                              ),
                            ),
                          ),
                          RadioMenuButton(
                            style: ButtonStyle(
                              iconSize: MaterialStateProperty.all(20),
                            ),
                            value: options[1],
                            groupValue: currentOption,
                            onChanged: (income) {
                              currentOption = income.toString();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          


  }

  void save(){

    ExpenseItem newExpense = ExpenseItem(name: itemController.text, amount: amountController.text, dateTime: pickedDate!);

    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

 


    Navigator.pop(context);
    clear();
  }


  void cancel(){


        Navigator.pop(context);
        clear();
  }

  void clear(){
    itemController.clear();
    amountController.clear();
    dateController.clear();

  }

  
  
  final itemController = TextEditingController();
  final amountController = TextEditingController();
  int amount = 0;
  final dateController = TextEditingController();
  int spentMoney = 0;
  DateTime? pickedDate;
  String currentOption = options[0];
  @override
  Widget build(BuildContext context) {

    return Consumer<ExpenseData>(builder: ((context, value, child) => Scaffold(
      
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        height: 67,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed:addNewExpense,
          child: const Icon(Icons.add, size: 26),
        ),
        
      ),
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        centerTitle: true,
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
       

        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                Padding(
                  
                  
                  padding: const EdgeInsets.only(top: 100),
                  child: FundCondition(
                    type: "DEPOSIT",
                    amount: "$spentMoney",
                    icon: "blue",
                  ),
                ),
                
                

            const SizedBox(height: 14),
            Expanded(

              child: ListView.builder(
              

                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Confirm to Delete the Item ?",
                              
                              style: TextStyle(
                                fontSize: 19.0,
                              ),
                            ),
                            actions: [
                              TextButton(
                                
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "CANCEL",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final myExpense = expenses[index];
                                  if (!myExpense.isIncome) {
                                    spentMoney -= myExpense.amount;
                                    setState(() {});
                                  }
                                  expenses.remove(myExpense);
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                
                                child: const Text(
                                  "DELETE",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Item(
                      
                      
                      expense: ExpenseModel(
                        item: expenses[index].item,
                        amount: expenses[index].amount,
                        isIncome: expenses[index].isIncome,
                        date: expenses[index].date,
                      ),
                      onDelete: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    )
    ),
    );
    
  }
}
