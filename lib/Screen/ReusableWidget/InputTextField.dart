import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool
      isPassword; // Add this field to distinguish if the field is a password field

  InputTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.isPassword = false,
    this.validator, // Default isPassword to false, so it works for username by default
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isObscured = true; // Manage the visibility of the password

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : TextInputType.name,
      obscureText:
          widget.isPassword ? _isObscured : false, // Conditionally obscure text
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            fontSize: 15, color: Color.fromARGB(221, 71, 71, 71)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Color(0xff60778C),
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured; // Toggle password visibility
                  });
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
