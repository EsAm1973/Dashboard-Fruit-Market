import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Row(
        children: [
          Icon(Icons.filter_alt_outlined, size: 30),
          SizedBox(width: 10),
          Text('Filter', style: AppTextStyles.semibold23),
        ],
      ),
    );
  }
}
