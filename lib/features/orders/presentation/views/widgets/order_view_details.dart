import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_product_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';
import 'package:fruit_market_dashboard/core/helper_functions/build_color_status_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Update%20Status%20Cubit/order_update_cubit.dart';
import 'package:fruit_market_dashboard/features/orders/presentation/manager/Order%20Update%20Status%20Cubit/order_update_states.dart';


class OrderDetailsScreen extends StatefulWidget {
  final OrderEntity order;
  /// optional fields because your OrderModel doesn't contain them
  final String? status;
  final DateTime? date;

  const OrderDetailsScreen({
    super.key,
    required this.order,
    this.status,
    this.date,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  OrderStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = _parseStatus(widget.status) ?? widget.order.status;
  }

  String _priceFmt(num price) => price.toDouble().toStringAsFixed(2);

  Widget _buildProductTile(BuildContext context, OrderProductEntity p) {
    final subtotal = p.price.toDouble() * p.quantity;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 72,
                height: 72,
                child: (p.imageUrl != null && p.imageUrl!.isNotEmpty)
                    ? Image.network(
                        p.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => _placeholderImage(),
                        loadingBuilder: (ctx, child, prog) {
                          if (prog == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: prog.expectedTotalBytes != null
                                  ? prog.cumulativeBytesLoaded /
                                      prog.expectedTotalBytes!
                                  : null,
                              strokeWidth: 2,
                            ),
                          );
                        },
                      )
                    : _placeholderImage(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text('Code: ${p.code}', style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${_priceFmt(p.price)} × ${p.quantity}', style: const TextStyle(fontSize: 13)),
                const SizedBox(height: 6),
                Text(_priceFmt(subtotal), style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage() => Container(
        color: Colors.grey[200],
        child: const Icon(Icons.image_not_supported, size: 36),
      );

  @override
  Widget build(BuildContext context) {
    // for update action
    // ignore: unused_local_variable
    // final updateCubit = context.read<OrderUpdateCubit>();
    final products = widget.order.orderProducts;
    final itemsCount = products.length;
    final total = widget.order.totalPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        actions: [
          IconButton(
            tooltip: 'Copy Order ID',
            icon: const Icon(Icons.copy),
            onPressed: () {
              // copy to clipboard (needs import of services if you want)
              // Clipboard.setData(ClipboardData(text: order.uID));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order ID copied')),
              );
            },
          ),
          IconButton(
            tooltip: 'Share',
            icon: const Icon(Icons.share),
            onPressed: () {
              // يمكن ربط بمكتبة share لإرسال تفاصيل الطلب
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ID, status and date row
                    Row(
                      children: [
                        Expanded(
                          child: Text('Order ID: ${widget.order.uID}', style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Items: $itemsCount'),
                            const SizedBox(height: 6),
                            Text(_priceFmt(total), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildStatusDropdown(),
                        const SizedBox(width: 8),
                        Text(widget.date != null ? _formatDate(widget.date!) : 'Date: —'),
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Products section
            const Text('Products', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...products.map((p) => _buildProductTile(context, p)),

            const SizedBox(height: 8),
            // Totals
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    _buildRowPair('Subtotal', _priceFmt(total)),
                    const SizedBox(height: 6),
                    // Example: taxes/shipping placeholders
                    _buildRowPair('Shipping', '0.00'),
                    const SizedBox(height: 6),
                    _buildRowPair('Tax', '0.00'),
                    const Divider(height: 18),
                    _buildRowPair('Total', _priceFmt(total), isBold: true),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Shipping Address
            const Text('Shipping Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.order.shippingAddressEntity.name ?? '—', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(widget.order.shippingAddressEntity.address ?? '—'),
                    if ((widget.order.shippingAddressEntity.addressDescription ?? '').isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(widget.order.shippingAddressEntity.addressDescription!),
                    ],
                    const SizedBox(height: 6),
                    Text('City: ${widget.order.shippingAddressEntity.city ?? '—'}'),
                    const SizedBox(height: 6),
                    Text('Phone: ${widget.order.shippingAddressEntity.phone ?? '—'}'),
                    const SizedBox(height: 6),
                    Text('Email: ${widget.order.shippingAddressEntity.email ?? '—'}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Payment method
            const Text('Payment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: Text(widget.order.paymentMethod),
                subtitle: Text('Payment status: ${_selectedStatus != null ? _statusLabel(_selectedStatus!) : (widget.status ?? _statusLabel(widget.order.status))}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // مثال لفتح صفحة الدفع/فاتورة
                  },
                  child: const Text('View invoice'),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Update Button (full width)
            BlocConsumer<OrderUpdateCubit, OrderUpdateState>(
              listener: (context, state) {
                if (state is OrderUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order status updated')),
                  );
                } else if (state is OrderUpdateFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${state.message}')),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is OrderUpdateLoading;
                return SizedBox(
              width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () async {
                            final selected = _selectedStatus;
                            if (selected == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please select a status')),
                              );
                              return;
                            }
                            context.read<OrderUpdateCubit>().updateOrderStatus(
                                  orderId: widget.order.id,
                                  status: selected,
                                );
                          },
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.save),
                    label: Text(isLoading ? 'Updating...' : 'Update Order Status'),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRowPair(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.w500)),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.w700 : FontWeight.normal)),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    // لو تريد تنسيق أجمل استخدم package:intl و DateFormat('yyyy-MM-dd – kk:mm')
    return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}';
  }

  String _two(int v) => v.toString().padLeft(2, '0');

  // UI: Status Dropdown
  Widget _buildStatusDropdown() {
    final current = _selectedStatus;
    final bgColor = current != null ? getStatusBackgroundColor(current) : Colors.grey.shade100;
    final fgColor = current != null ? getStatusColor(current) : Colors.grey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fgColor.withOpacity(0.25)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderStatus>(
          value: current,
          hint: Text(widget.status ?? 'Select status', style: TextStyle(color: fgColor)),
          icon: Icon(Icons.arrow_drop_down, color: fgColor),
          items: OrderStatus.values.map((s) {
            return DropdownMenuItem<OrderStatus>(
              value: s,
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: BoxDecoration(color: getStatusColor(s), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  Text(_statusLabel(s)),
                ],
              ),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _selectedStatus = newVal;
            });
          },
        ),
      ),
    );
  }

  // Helpers
  OrderStatus? _parseStatus(String? value) {
    if (value == null) return null;
    final v = value.trim().toLowerCase();
    for (final s in OrderStatus.values) {
      if (_statusLabel(s).toLowerCase() == v || s.name.toLowerCase() == v) {
        return s;
      }
    }
    return null;
  }

  String _statusLabel(OrderStatus s) {
    switch (s) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.returned:
        return 'Returned';
    }
  }
}
