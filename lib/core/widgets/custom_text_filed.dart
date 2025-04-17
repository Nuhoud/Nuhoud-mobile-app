import 'package:flutter/material.dart';
import '../utils/app_constats.dart';
import '../utils/styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.borderColor,
    required this.text,
    required this.isPassword,
    this.maxLine = 1,
    required this.controller,
    this.validatorFun,
    this.keyboardType,
    this.onChange,
    this.prefixIcon,
  });
  final String text;
  final bool isPassword;
  final int maxLine;
  final TextEditingController controller;
  final String? Function(String?)? validatorFun;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final void Function(String?)? onChange;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassowrd = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        style: Styles.textStyle13.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white70,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white54,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          labelText: widget.text,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Colors.white70,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    showPassowrd
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassowrd = !showPassowrd;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
        ),
      ),
    );
  }
}
