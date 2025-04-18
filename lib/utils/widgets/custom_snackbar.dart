import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F3), // Light red background
          borderRadius: BorderRadius.circular(8), // Border like in the image
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Color(0xFFFF4D4F)), // Red text
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: const Icon(Icons.close, color: Color(0xFFFF4D4F), size: 16),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
