import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/themes/app_colors.dart';

class PrimaryTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool isFieldValidated;
  final bool isForgetButton;
  final bool isPasswordField;
  final bool isPhone;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final String? labelText;
  const PrimaryTextformfield({
    super.key,
    this.hintText,
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
  });

  @override
  State<PrimaryTextformfield> createState() => _PrimaryTextformfieldState();
}

class _PrimaryTextformfieldState extends State<PrimaryTextformfield> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? isObscure : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorMaxLines: 2,
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
          suffixIcon: widget.isForgetButton
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.kPrimary,
                  ),
                )
              : Icon(widget.isPhone ? Icons.phone_android : Icons.done,
                  size: 20,
                  color: widget.isFieldValidated
                      ? AppColors.kPrimary
                      : AppColors.kLine)),
    );
  }
}
