import 'package:flutter/material.dart';

import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/InputTextField.dart';

class CreatePasswordScreen extends StatefulWidget {
  CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController oldpsdcontroller = TextEditingController();
  TextEditingController newpsdcontroller = TextEditingController();
  bool value = false;
  final _formKey = GlobalKey<FormState>();
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$', // At least 8 chars, 1 letter, 1 number
  );

  String? _validateConfirmPassword(
      String? newPassword, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your new password';
    } else if (confirmPassword != newPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password';
    } else if (!_passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long and include a letter and a number';
    }
    return null;
  }

  void _Csubmit() {
    if (_formKey.currentState?.validate() == true) {
      oldpsdcontroller.text = '';
      newpsdcontroller.text = '';
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
                    'Create a New Password',
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
                      controller: oldpsdcontroller,
                      validator: (value) => _validateNewPassword(value),
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
                      controller: oldpsdcontroller,
                      isPassword: true,
                      validator: (value) => _validateConfirmPassword(
                          newpsdcontroller.text, value),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Mybutton(
                    buttontext: 'SAVE',
                    OnTap: () {
                      _Csubmit();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => OTPScreen()),
                      // );
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
