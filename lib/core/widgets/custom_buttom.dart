import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_colors.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, required this.onpressed, required this.text});
  final VoidCallback onpressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: TextButton(
        onPressed: onpressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(text,style: AppTextStyles.bold16,),
      ),
    );
  }
}
