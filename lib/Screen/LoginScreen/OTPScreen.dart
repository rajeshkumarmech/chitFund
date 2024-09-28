import 'package:flutter/material.dart';
import 'package:foxlchitcustomer/Screen/LoginScreen/CreateNewPassword.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/OtpTextField.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to validate OTP input
  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    }
    if (value.length != 4) {
      return 'OTP must be 4 digits long'; // Adjust the length to 4
    }
    return null;
  }

  void _verifyOTP() {
    if (_formKey.currentState?.validate() == true) {
      otpController.text = '';
      // Handle OTP verification here
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreatePasswordScreen()),
      );
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
                          otpController: otpController,
                          otpLength: 4,
                          validator: (value) {
                            // Call the validate function here
                            return _validateOtp(value);
                          },
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
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Mybutton(
                    buttontext: 'VERIFY',
                    OnTap: _verifyOTP,
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
