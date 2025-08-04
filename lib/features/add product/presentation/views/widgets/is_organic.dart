import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';

class IsOrganicCheckBox extends StatefulWidget {
  const IsOrganicCheckBox({super.key, required this.onChecked});
  final ValueChanged<bool> onChecked;
  @override
  _IsOrganicCheckBoxState createState() => _IsOrganicCheckBoxState();
}

class _IsOrganicCheckBoxState extends State<IsOrganicCheckBox> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.4,
          child: Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(color: Colors.black, width: 1.50),
            value: _agreed,

            onChanged: (value) {
              widget.onChecked(value ?? false);
              setState(() {
                _agreed = value ?? false;
              });
            },
          ),
        ),
        // لجعل النص يلتف تلقائياً ضمن المساحة المتاحة
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Is Organic Product',
                  style: AppTextStyles.semibold16.copyWith(
                    color: const Color(0xFF616A6B),
                    height: 1.70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
