import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
    this.maxLines = 1,
  });
  final String hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Function(String?)? onSaved;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        label: Text(hintText),
        hintStyle: AppTextStyles.bold13.copyWith(
          color: const Color(0xFF949D9E),
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        suffixIcon: suffixIcon,
        suffixIconColor: const Color(0xFFC9CECF),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFE6E9E9), width: 1),
    );
  }
}
