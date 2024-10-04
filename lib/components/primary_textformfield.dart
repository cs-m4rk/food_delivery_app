import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class PrimaryTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final Icon? prefixIcon;
  final bool isFieldValidated;
  final bool isForgetButton;
  final IconButton? suffixIcon;
  final bool isPasswordField;
  final bool obscureText;
  final bool isPhone;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? labelText;
  const PrimaryTextformfield(
      {super.key,
      this.hintText,
      this.prefixIcon,
      required this.controller,
      this.inputFormatters,
      this.onChanged,
      this.isFieldValidated = false,
      this.validator,
      this.isPhone = false,
      this.isPasswordField = false,
      this.isForgetButton = false,
      this.keyboardType,
      this.labelText,
      this.suffixIcon,
      this.obscureText = false});

  @override
  State<PrimaryTextformfield> createState() => _PrimaryTextformfieldState();
}

class _PrimaryTextformfieldState extends State<PrimaryTextformfield> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        labelText: widget.labelText,
        filled: false,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.kLine),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.grey),
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
