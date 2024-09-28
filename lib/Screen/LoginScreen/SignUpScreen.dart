import 'package:flutter/material.dart';
import 'package:foxlchitcustomer/Screen/LoginScreen/OTPScreen.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/GoogleSigninButton.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/InputTextField.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/TextButton.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userregcontroller = TextEditingController();

  bool value = false;
  final _formKey = GlobalKey<FormState>();

  // Regular expression for email validation
  final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Regular expression for phone number validation (10 digits, starting with [6-9])
  final RegExp _phoneRegExp = RegExp(
    r'^[0-9]\d{9}$',
  );

  // Validation function
  String? _validateReg(String value) {
    if (value.isEmpty) {
      return 'Please enter an email or phone number';
    } else if (_phoneRegExp.hasMatch(value)) {
      if (value.length != 10) {
        return 'Phone number must be exactly 10 digits';
      }
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email or phone number';
    }
    return null;
  }

  void _Rsubmit() {
    if (_formKey.currentState?.validate() == true) {
      userregcontroller.text = '';

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OTPScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid user ID and password',
          ),
        ),
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
            right: -screenWidth * 0.04,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Create a New Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 26,
                      height: 40.35 / 26,
                      fontWeight: FontWeight.w700,
                    ),
                    // Aligns text to the left
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Please Enter Your Email or Mobile Number',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'To Receive a Verification Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email/Mobile number',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    width: screenWidth * 0.9,
                    child: InputTextField(
                      hint: 'autochit@gmail.com',
                      controller: userregcontroller,
                      validator: (value) => _validateReg(value ?? ''),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Mybutton(
                    buttontext: 'SEND OTP',
                    OnTap: () {
                      _Rsubmit();
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        height: 0.5,
                        color: const Color(0xff514B6B),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Or',
                        style: TextStyle(
                          color: Color(0xff514B6B),
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        width: screenWidth * 0.5,
                        height: 0.5,
                        color: const Color(0xff514B6B),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  GoogleSigninButton(
                    Googletext: 'Sign in with Google',
                    imagePath: 'images/GoogleImage.png',
                    GoogleSignin: () {},
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  TextButtonUser(
                    textreg: 'Sign in',
                    newbuttonregister: () {},
                  )
                ],
              ),
            ),
          ),

          // Positioned(
          //   top: 530,
          //   left: -30,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Container(
          //             width: 200,
          //             height: 0.5,
          //             color: const Color(0xff514B6B), // Divider color
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           const Text(
          //             'Or',
          //             style: TextStyle(
          //               color: Color(0xff514B6B),
          //               fontSize: 12,
          //               fontFamily: 'OpenSans',
          //               fontWeight: FontWeight.w700,
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 5,
          //           ),
          //           Container(
          //             width: 200,
          //             height: 0.5,
          //             color: const Color(0xff514B6B), // Divider color
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
