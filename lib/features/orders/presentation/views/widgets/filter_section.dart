import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/core/helper_functions/build_color_status_product.dart';
import 'package:fruit_market_dashboard/core/utils/app_text_styles.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';

class FilterSection extends StatefulWidget {
  final OrderStatus? selectedStatus;
  final Function(OrderStatus?) onStatusChanged;

  const FilterSection({
    super.key,
    this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Header
        Row(
          children: [
            const Icon(Icons.filter_alt_outlined, size: 30),
            const SizedBox(width: 10),
            const Text('Filter', style: AppTextStyles.semibold23),
            const Spacer(),
            if (widget.selectedStatus != null)
              GestureDetector(
                onTap: () => widget.onStatusChanged(null),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.clear, size: 16),
                      SizedBox(width: 4),
                      Text('Clear', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Status Filter Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // All Orders Chip
              _buildStatusChip(
                'All Orders',
                null,
                widget.selectedStatus == null,
              ),
              const SizedBox(width: 8),
              
              // Status Chips
              ...OrderStatus.values.map((status) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildStatusChip(
                  status.displayName,
                  status,
                  widget.selectedStatus == status,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label, OrderStatus? status, bool isSelected) {
    Color chipColor = isSelected ? Colors.blue : Colors.grey[300]!;
    Color textColor = isSelected ? Colors.white : Colors.grey[700]!;
    
    if (status != null && !isSelected) {
      chipColor = getStatusBackgroundColor(status);
      textColor = getStatusColor(status);
    }

    return GestureDetector(
      onTap: () => widget.onStatusChanged(status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (status != null) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: textColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
