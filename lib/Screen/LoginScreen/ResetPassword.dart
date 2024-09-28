import 'package:flutter/material.dart';

import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/InputTextField.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController Resetoldpsdcontroller = TextEditingController();
  TextEditingController Resetnewpsdcontroller = TextEditingController();
  bool value = false;
  final _formKey = GlobalKey<FormState>();
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$', // At least 8 chars, 1 letter, 1 number
  );

  String? Function(String?) _validateConfirmResetPassword(String newPassword) {
    return (confirmPassword) {
      if (confirmPassword == null || confirmPassword.isEmpty) {
        return 'Please confirm your new password';
      } else if (confirmPassword != newPassword) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  String? _validateNewResetPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include a letter and a number';
    }
    return null;
  }

  void _Resetsubmit() {
    if (_formKey.currentState?.validate() == true) {
      Resetoldpsdcontroller.text = '';
      Resetnewpsdcontroller.text = '';
      // If the form is valid, process the data
      print("Passwords validated successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/LoginpageBGimage.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: -screenHeight * 0.04,
            right: -screenWidth * 0.05,
            child: CircleAvatar(
              radius: screenWidth * 0.24,
              backgroundImage: const AssetImage('images/Circle.png'),
            ),
          ),
          Positioned(
            top: screenHeight * 0.01,
            right: screenWidth * 0.02,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: screenWidth * 0.18,
              backgroundImage: const AssetImage('images/FOXL Logo.png'),
            ),
          ),
          Positioned(
            top: screenHeight * 0.20,
            right: screenWidth * 0.045,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Reset a New Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 26,
                      height: 40.35 / 26,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left, // Aligns text to the left
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Enter New Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: InputTextField(
                      hint: 'New Password',
                      controller: Resetoldpsdcontroller,
                      validator: _validateNewResetPassword,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Conform Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: InputTextField(
                      hint: 'Conform Password',
                      controller: Resetnewpsdcontroller,
                      isPassword: true,
                      validator: _validateConfirmResetPassword(
                          Resetnewpsdcontroller.text),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Mybutton(
                    buttontext: 'SAVE',
                    OnTap: () {
                      _Resetsubmit();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => OTPScreen()),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
