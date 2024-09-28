import 'package:flutter/material.dart';
import 'package:foxlchitcustomer/Screen/LoginScreen/ForgotPasswordScreen.dart';
import 'package:foxlchitcustomer/Screen/LoginScreen/SignUpScreen.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/GoogleSigninButton.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/InputTextField.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/TextButton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController useridcontroller = TextEditingController();
  TextEditingController userpsdcontroller = TextEditingController();
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
  // Validation function
  String? _validateInput(String value) {
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

  void _submit() {
    if (_formKey.currentState?.validate() == true) {
      useridcontroller.text = '';
      userpsdcontroller.text = '';

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const TopicButton()),
      // );
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
              backgroundColor: Color.fromARGB(255, 36, 63, 121),
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
            right: -screenWidth * 0.035,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30,
                        height: 40.35 / 30,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left, // Aligns text to the left
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
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
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: InputTextField(
                        hint: 'autochit@gmail.com',
                        controller: useridcontroller,
                        validator: (value) => _validateInput(value ?? ''),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: InputTextField(
                        hint: 'Enter Password',
                        controller: userpsdcontroller,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: SizedBox(
                      width: screenWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: screenHeight * 0.03,
                                  width: screenHeight * 0.03,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Colors.white,
                                  ),
                                  child: Transform.scale(
                                    scale: 1.1,
                                    child: Checkbox(
                                      checkColor: Colors.black,
                                      side:
                                          const BorderSide(color: Colors.white),
                                      value: value,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          value = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Mybutton(
                    buttontext: 'LOGIN',
                    OnTap: _submit,
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
                  TextButtonUser(
                    textreg: 'Sign up',
                    newbuttonregister: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
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
