import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
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
    this.fillColor,
    this.hPadding,
    this.vPadding,
    this.hintText,
  });
  final String text;
  final bool isPassword;
  final int maxLine;
  final TextEditingController controller;
  final String? Function(String?)? validatorFun;
  final Color? borderColor;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final void Function(String?)? onChange;
  final IconData? prefixIcon;
  final double? hPadding;
  final double? vPadding;
  final String? hintText;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void dispose() {
    super.dispose();
  }

  bool showPassowrd = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.vPadding ?? 15, horizontal: widget.hPadding ?? 1),
      child: TextFormField(
        style: Styles.textStyle13.copyWith(
          color: AppColors.blackTextColor,
          fontWeight: FontWeight.w500,
        ),
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        textInputAction: TextInputAction.next,
        validator: widget.validatorFun,
        controller: widget.controller,
        maxLines: widget.maxLine,
        obscureText: widget.isPassword ? !showPassowrd : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Styles.textStyle13.copyWith(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          labelText: widget.text,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: AppColors.secodaryColor,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    showPassowrd
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.secodaryColor,
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
              borderSide: BorderSide.none),
          fillColor: widget.fillColor ?? AppColors.fillTextFiledColor,
          filled: true,
        ),
      ),
    );
  }
}
