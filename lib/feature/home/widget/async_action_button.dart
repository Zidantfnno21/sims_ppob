import 'package:flutter/material.dart';

import '../../../data/network/status.dart';

class AsyncActionButton extends StatelessWidget {
  final Status? status;
  final String text;
  final VoidCallback? onPressed;

  const AsyncActionButton({
    super.key,
    required this.status,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = status == Status.loading;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDisabled ? Colors.grey : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}