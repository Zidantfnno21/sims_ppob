import 'package:flutter/material.dart';

class CustomEmailField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomEmailField({
    super.key,
    required this.controller,
    required this.hintText
  });

  @override
  State<CustomEmailField> createState() => CustomEmailFieldState();
}

class CustomEmailFieldState extends State<CustomEmailField> {
  bool showError = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty && showError) {
        setState(() {
          showError = false;
        });
      }
    });
  }

  void triggerError() {
    if (widget.controller.text.trim().isEmpty) {
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = showError ? Colors.red : Colors.grey;
    final Color iconColor = showError ? Colors.red : Colors.black;

    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: Icon(Icons.email_outlined, color: iconColor),
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
    );
  }
}