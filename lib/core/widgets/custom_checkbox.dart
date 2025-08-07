import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';

class IsFeaturedCheckBox extends StatefulWidget {
  const IsFeaturedCheckBox({super.key, required this.onChecked});
  final ValueChanged<bool> onChecked;
  @override
  _IsFeaturedCheckBoxState createState() => _IsFeaturedCheckBoxState();
}

class _IsFeaturedCheckBoxState extends State<IsFeaturedCheckBox> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Is Featured Product',
                    style: AppTextStyles.semibold16.copyWith(
                      color: const Color(0xFF616A6B),
                      height: 1.70,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 1.4,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: Colors.black, width: 1.50),
              value: _agreed,
      
              onChanged: (value) {
                widget.onChecked(value ?? false);
                setState(() {
                  _agreed = value ?? false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
