import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/OtpTextField.dart';
import 'package:http/http.dart' as http;
import 'package:sms_autofill/sms_autofill.dart';

import 'CreateNewPassword.dart'; // For OTP autofill

class PhoneOTPScreen extends StatefulWidget {
  final String phoneNumber;
  PhoneOTPScreen({super.key, required this.phoneNumber});

  @override
  State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> with CodeAutoFill {
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false; // Indicates the loading state for OTP verification
  String? _otpCode; // Holds the OTP code for autofill

  @override
  void initState() {
    super.initState();
    listenForCode(); // Start listening for auto-fill OTP
  }

  @override
  void dispose() {
    otpController.dispose();
    cancel(); // Stop listening when the widget is disposed
    super.dispose();
  }

  // Function to validate OTP input
  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the OTP';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits long';
    }
    return null;
  }

  final String _baseUrl = 'https://chitsoft.in/wapp/api/mobile2/index.php';

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    if (_validateOtp(otp) != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 179, 104, 214),
          content: Text(
            'Please enter a Otp.',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
      return; // Exit if the validation fails
    }
    setState(() {
      _isLoading = true; // Show the loader when verification starts
    });

    final url = Uri.parse(_baseUrl);
    final response = await http.post(url, body: {
      'type': '3',
      'cid': '21472147',
      'id': '567',
      'mobile': phoneNumber,
      'otp': otp,
    });

    setState(() {
      _isLoading = false; // Hide the loader after response
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic>) {
        // Check for error in response
        if (responseData.containsKey('error') &&
            responseData['error'] == true) {
          var errorMessage = responseData[
              'error_msg']; // Assuming 'error_msg' holds the error details

          // Check if errorMessage is a Map or String
          if (errorMessage is Map<String, dynamic>) {
            // Handle the case if errorMessage itself is a map (e.g., it might have subfields)
            errorMessage = errorMessage['message'] ??
                'Invalid OTP. Please try again.'; // Adjust the key accordingly
          }

          // Ensure it's a String before calling toLowerCase
          if (errorMessage is String &&
              errorMessage.toLowerCase().contains('invalid otp')) {
            _showSnackbar('Invalid OTP. Please try again.', Colors.red);
          } else if (errorMessage is String) {
            _showSnackbar(errorMessage, Colors.red);
          } else {
            _showSnackbar('Invalid OTP. Please try again.', Colors.red);
          }
        } else {
          _showSnackbar('OTP verified successfully', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePasswordScreen()),
          );
        }
      } else {
        _showSnackbar('Unexpected response from the server.', Colors.red);
      }
    } else {
      _showSnackbar('Failed to verify OTP. Please try again.', Colors.red);
      print('Failed to verify OTP: ${response.statusCode}');
    }
  }

  // Resend OTP functionality
  Future<void> resendOtp(String phoneNumber) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(_baseUrl);
    final response = await http.post(url, body: {
      'type': '2', // Different type for resend OTP
      'cid': '21472147',
      'id': '567',
      'mobile': phoneNumber,
    });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic> &&
          responseData['error'] != true) {
        _showSnackbar('OTP resent successfully', Colors.green);
      } else {
        _showSnackbar('Failed to resend OTP. Try again later.', Colors.red);
      }
    } else {
      _showSnackbar('Server error while resending OTP.', Colors.red);
    }
  }

  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      _otpCode = code; // Set OTP code automatically when received
      otpController.text = _otpCode ?? ''; // Auto-fill OTP in the text field
    });
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
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  const Text(
                    'Please Enter The 6 Digit Code Sent to',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(
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
                          otpLength: 6,
                          validator: _validateOtp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  GestureDetector(
                    onTap: () async {
                      await resendOtp(widget.phoneNumber); // Resend OTP
                    },
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Mybutton(
                          buttontext: 'VERIFY',
                          OnTap: () async {
                            if (_formKey.currentState?.validate() ?? true) {
                              await verifyOtp(
                                  widget.phoneNumber, otpController.text);
                            }
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


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
// import 'package:foxlchitcustomer/Screen/ReusableWidget/OtpTextField.dart';
// import 'package:http/http.dart' as http;

// class PhoneOTPScreen extends StatefulWidget {
//   final String phoneNumber;
//   PhoneOTPScreen({super.key, required this.phoneNumber});

//   @override
//   State<PhoneOTPScreen> createState() => _PhoneOTPScreenState();
// }

// class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
//   TextEditingController otpController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   // Function to validate OTP input
//   String? _validateOtp(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Please enter the OTP';
//     }
//     if (value.length != 6) {
//       return 'OTP must be 6 digits long'; // Ensure length is 6
//     }
//     return null;
//   }

//   final String _baseUrl = 'https://chitsoft.in/wapp/api/mobile2/index.php';

//   Future<void> verifyOtp(String phoneNumber, String otp) async {
//     final url = Uri.parse(_baseUrl);
//     final response = await http.post(url, body: {
//       'type': '3',
//       'cid': '21472147',
//       'id': '567', // Type for verifying OTP
//       'mobile': phoneNumber,
//       'otp': otp, // Pass the OTP as a String
//     });

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);

//       if (responseData is Map<String, dynamic>) {
//         if (responseData.containsKey('error_msg')) {
//           final errorMessage = responseData['error_msg'];

//           // Handle specific error messages
//           if (errorMessage.toLowerCase().contains('invalid otp') ||
//               errorMessage.toLowerCase().contains('wrong otp')) {
//             Future<void> verifyOtp(String phoneNumber, String otp) async {
//               final url = Uri.parse(_baseUrl);
//               final response = await http.post(url, body: {
//                 'type': '3',
//                 'cid': '21472147',
//                 'id': '567', // Type for verifying OTP
//                 'mobile': phoneNumber,
//                 'otp': otp, // Pass the OTP as a String
//               });

//               if (response.statusCode == 200) {
//                 final responseData = json.decode(response.body);

//                 if (responseData is Map<String, dynamic>) {
//                   if (responseData.containsKey('error_msg')) {
//                     final errorMessage = responseData['error_msg'];

//                     // Handle specific error messages
//                     if (errorMessage.toLowerCase().contains('invalid otp') ||
//                         errorMessage.toLowerCase().contains('wrong otp')) {
//                       // ignore: use_build_context_synchronously
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           backgroundColor: Colors.red,
//                           content: Text(
//                             'Invalid OTP. Please try again.',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     } else {
//                       // ignore: use_build_context_synchronously
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           backgroundColor: Colors.red,
//                           content: Text(
//                             errorMessage,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       );
//                     }
//                   } else {
//                     // OTP verification successful
//                     // ignore: use_build_context_synchronously
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         backgroundColor: Color.fromARGB(255, 10, 115, 48),
//                         content: Text(
//                           'OTP verified successfully',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     );

//                     // Navigate to the next screen if needed
//                     // Uncomment and update the target screen as necessary
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => NextScreen(), // Replace with your target screen
//                     //   ),
//                     // );
//                   }
//                 } else {
//                   // ignore: use_build_context_synchronously
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       backgroundColor: Colors.red,
//                       content: Text(
//                         'Unexpected response from the server.',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }
//               } else {
//                 // ignore: use_build_context_synchronously
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     backgroundColor: Colors.red,
//                     content: Text(
//                       'Failed to verify OTP. Please try again.',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//                 print('Failed to verify OTP: ${response.statusCode}');
//               }
//             }

//             // ignore: use_build_context_synchronously
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 backgroundColor: Colors.red,
//                 content: Text(
//                   'Invalid OTP. Please try again.',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             );
//           } else {
//             // ignore: use_build_context_synchronously
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 backgroundColor: Colors.green,
//                 content: Text(
//                   errorMessage,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             );
//           }
//         } else {
//           // OTP verification successful
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               backgroundColor: Color.fromARGB(255, 10, 115, 48),
//               content: Text(
//                 'OTP verified successfully',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           );

//           // Navigate to the next screen if needed
//           // Uncomment and update the target screen as necessary
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => NextScreen(), // Replace with your target screen
//           //   ),
//           // );
//         }
//       } else {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             backgroundColor: Colors.red,
//             content: Text(
//               'Unexpected response from the server.',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         );
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text(
//             'Failed to verify OTP. Please try again.',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//       print('Failed to verify OTP: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: screenHeight,
//             width: screenWidth,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/LoginpageBGimage.jpeg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -screenHeight * 0.04,
//             right: -screenWidth * 0.05,
//             child: CircleAvatar(
//               radius: screenWidth * 0.24,
//               backgroundImage: const AssetImage('images/Circle.png'),
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.01,
//             right: screenWidth * 0.02,
//             child: CircleAvatar(
//               backgroundColor: Colors.transparent,
//               radius: screenWidth * 0.18,
//               backgroundImage: const AssetImage('images/FOXL Logo.png'),
//             ),
//           ),
//           Positioned(
//             top: screenHeight * 0.20,
//             right: screenWidth * 0.045,
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Enter OTP',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       fontSize: 26,
//                       height: 40.35 / 26,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.05),
//                   const Text(
//                     'Please Enter The 6 Digit Code Sent to',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.02),
//                   Text(
//                     widget.phoneNumber,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.05),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: screenWidth * 0.9,
//                         child: OtpInputField(
//                           otpController: otpController,
//                           otpLength: 6,
//                           validator: (value) {
//                             // Call the validate function here
//                             return _validateOtp(value);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: screenHeight * 0.05),
//                   const Text(
//                     'Resend Code',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'OpenSans',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                   SizedBox(height: screenHeight * 0.04),
//                   Mybutton(
//                     buttontext: 'VERIFY',
//                     OnTap: () async {
//                       String otp = otpController.text;
//                       if (_formKey.currentState?.validate() ?? false) {
//                         await verifyOtp(widget.phoneNumber, otp);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
