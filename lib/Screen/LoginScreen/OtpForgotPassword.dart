import 'package:flutter/material.dart';

import 'package:foxlchitcustomer/Screen/LoginScreen/ResetPassword.dart';

import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/OtpTextField.dart';

class OTPForgotPasswordScreen extends StatefulWidget {
  OTPForgotPasswordScreen({super.key});

  @override
  State<OTPForgotPasswordScreen> createState() =>
      _OTPForgotPasswordScreenState();
}

class _OTPForgotPasswordScreenState extends State<OTPForgotPasswordScreen> {
  TextEditingController otpForgotPasswordcontroller = TextEditingController();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width using MediaQuery
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Enter OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 26,
                    height: 40.35 / 26,
                    fontWeight: FontWeight.w700,
                  ),
                  // Aligns text to the left
                ),
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  'Please Enter The 4 Digit Code Sent to',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                const Text(
                  'xxxxx@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.9,
                      child: OtpInputField(
                        otpController: otpForgotPasswordcontroller,
                        otpLength: 4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  'Resend Code',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: screenHeight * 0.04),
                Mybutton(
                  buttontext: 'VERIFY',
                  OnTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
