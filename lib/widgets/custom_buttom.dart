import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Cambiado a nullable

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled
              ? const Color(0xFF7D2E1E).withOpacity(0.6)
              : const Color(0xFF7D2E1E),
          foregroundColor: isDisabled
              ? Colors.white.withOpacity(0.6)
              : Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDisabled
                ? Colors.white.withOpacity(0.6)
                : Colors.white,
          ),
        ),
      ),
    );
  }
}