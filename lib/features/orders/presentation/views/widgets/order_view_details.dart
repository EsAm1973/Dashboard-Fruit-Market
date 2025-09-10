import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_product_entity.dart';

class OrderDetailsScreen extends StatelessWidget {
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
    final products = order.orderProducts;
    final itemsCount = products.length;
    final total = order.totalPrice;

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
                          child: Text('Order ID: ${order.uID}', style: const TextStyle(fontWeight: FontWeight.w700)),
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
                        Chip(
                          label: Text(status ?? '—'),
                          backgroundColor: (status?.toLowerCase() == 'pending') ? Colors.orange[50] : Colors.green[50],
                        ),
                        const SizedBox(width: 8),
                        Text(date != null ? _formatDate(date!) : 'Date: —'),
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
                    Text(order.shippingAddressEntity.name ?? '—', style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(order.shippingAddressEntity.address ?? '—'),
                    if ((order.shippingAddressEntity.addressDescription ?? '').isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(order.shippingAddressEntity.addressDescription!),
                    ],
                    const SizedBox(height: 6),
                    Text('City: ${order.shippingAddressEntity.city ?? '—'}'),
                    const SizedBox(height: 6),
                    Text('Phone: ${order.shippingAddressEntity.phone ?? '—'}'),
                    const SizedBox(height: 6),
                    Text('Email: ${order.shippingAddressEntity.email ?? '—'}'),
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
                title: Text(order.paymentMethod),
                subtitle: Text('Payment status: ${status ?? '—'}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    // مثال لفتح صفحة الدفع/فاتورة
                  },
                  child: const Text('View invoice'),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Reorder action
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reorder tapped')));
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reorder'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Track shipment (needs implementation)
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Track shipment tapped')));
                    },
                    icon: const Icon(Icons.local_shipping),
                    label: const Text('Track Shipment'),
                  ),
                ),
              ],
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
}
