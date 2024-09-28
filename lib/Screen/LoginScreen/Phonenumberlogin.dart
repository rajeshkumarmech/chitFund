import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foxlchitcustomer/Screen/LoginScreen/OtpPhoneNumber.dart';
import 'package:foxlchitcustomer/Screen/ReusableWidget/Button.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneLoginScreen extends StatefulWidget {
  PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  TextEditingController Phonenumbercontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Move GlobalKey inside Form
  String phoneNumber = '';

  // Regular expression for phone number validation (10 digits)
  final RegExp _phoneRegExp = RegExp(r'^\d{10}$');

  // Validation function for phone number
  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    } else if (value.length != 10) {
      return 'Phone number must be exactly 10 digits';
    } else if (!_phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Submit function to send phone number and request OTP
  Future<void> _submit() async {
    if (_formKey.currentState?.validate() == true) {
      String phoneNumber = Phonenumbercontroller.text;

      // Check if the phone number is valid
      if (_validateInput(phoneNumber) != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid phone number.'),
          ),
        );
        return; // Exit if the validation fails
      }
      try {
        const String url = 'https://chitsoft.in/wapp/api/mobile2/index.php';
        final response = await http.post(Uri.parse(url), body: {
          'type': '2',
          'cid': '21472147',
          'mobile': Phonenumbercontroller.text,
        });

        if (response.statusCode == 200) {
          try {
            var jsonResponse =
                json.decode(response.body); // Try decoding the JSON

            if (jsonResponse['error_msg'] == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to send OTP'),
                ),
              );
            } else {
              Phonenumbercontroller.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP sent successfully.'),
                ),
              );

              // Navigate to the OTP verification screen
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhoneOTPScreen(
                    phoneNumber: phoneNumber,
                  ),
                ),
              );
            }
          } catch (e) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to parse server response.'),
              ),
            );
          }
        } else {
          print('HTTP Error: ${response.statusCode}');
          print('Error response: ${response.body}');
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error ${response.statusCode}: Failed to send the phone number. Please try again.',
              ),
            ),
          );
        }
      } catch (e) {
        // Handle any other errors such as network issues
        print('Network error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid phone number.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height and width
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
              backgroundColor: const Color.fromARGB(255, 36, 63, 121),
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
              key: _formKey, // Correct placement of form key
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
                      textAlign: TextAlign.left,
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
                          'Mobile number',
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
                      child: IntlPhoneField(
                        controller: Phonenumbercontroller,
                        dropdownTextStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'DMSans',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'DMSans',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        flagsButtonPadding: const EdgeInsets.all(8),
                        dropdownIconPosition: IconPosition.trailing,

                        decoration: InputDecoration(
                          prefixIconColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          phoneNumber = phone.completeNumber;
                        },
                        pickerDialogStyle: PickerDialogStyle(
                          // Add customization here
                          backgroundColor:
                              Color(0xffc393c3), // Change the dialog background
                          searchFieldInputDecoration: InputDecoration(
                            // Customize search field
                            labelText: 'Search country',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          countryNameStyle: const TextStyle(
                            // Style for country name text
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          countryCodeStyle: const TextStyle(
                            // Style for country code text
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        validator: (phone) =>
                            _validateInput(phone?.number), // Validation added
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  const SizedBox(height: 20),
                  Mybutton(
                    buttontext: 'Send',
                    OnTap: () async {
                      await _submit(); // Await the asynchronous function inside a synchronous handler
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
