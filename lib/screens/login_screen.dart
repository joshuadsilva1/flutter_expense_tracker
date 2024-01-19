import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/widgets/custom_widget.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginStateScreen();
}

class _LoginStateScreen extends State<LoginScreen> {

  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:0.0),
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Text('Welcome to the expense tracker app',style: TextStyle(
            fontSize: 35,
            fontFamily: 'Robotto',
          
      
      
          ),
          
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Image.asset('assets/images/expenselogo.jpeg'),
          ),
           CustomButton(
            text: 'Google Sign In',
            onPressed: () async {
              bool res = await _authMethods.signInWithGoogle(context);
              if (res) {
                Navigator.pushNamed(context, '/home-screen');
              }
            },
          ),
            ],
      
          ),
      
      
      
      ),
    );
  }
}
