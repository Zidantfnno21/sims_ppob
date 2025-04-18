import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  CustomPasswordFieldState createState() => CustomPasswordFieldState();
}

class CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPasswordVisible = false;
  bool showError = false;
  String? errorText;

  void triggerError([String? customError]) {
    final isEmpty = widget.controller.text.trim().isEmpty;

    setState(() {
      if (isEmpty) {
        showError = true;
        errorText = null;
      } else if (customError != null && customError.isNotEmpty) {
        showError = true;
        errorText = customError;
      } else {
        showError = false;
        errorText = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (showError || errorText != null) {
        setState(() {
          showError = false;
          errorText = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = showError || errorText != null;
    final Color borderColor = hasError ? Colors.red : Colors.grey;
    final Color iconColor = hasError ? Colors.red : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(Icons.lock_outline, color: iconColor),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: iconColor,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
