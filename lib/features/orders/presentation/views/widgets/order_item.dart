import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_entity.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_product_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback? onTap;
  final bool initiallyExpanded;

  const OrderItemWidget({
    super.key,
    required this.order,
    this.onTap,
    this.initiallyExpanded = false,
  });

  String _priceFmt(num price) => price.toDouble().toStringAsFixed(2);

  Widget _buildProductRow(OrderProductEntity p) {
    final subtotal = (p.price * p.quantity);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // الصورة مع fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 64,
              height: 64,
              child: (p.imageUrl != null && p.imageUrl!.isNotEmpty)
                  ? Image.network(
                      p.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, e, st) => _placeholderImage(),
                      loadingBuilder: (ctx, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
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
          // تفاصيل المنتج
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  'Code: ${p.code}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // سعر × الكمية و المجموع
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${_priceFmt(p.price)} × ${p.quantity}',
                  style: const TextStyle(fontSize: 13)),
              const SizedBox(height: 6),
              Text(
                _priceFmt(subtotal),
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Header: Order ID | Total Price
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: ${order.uID}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$itemsCount items • ${order.shippingAddressEntity.city ?? '—'}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _priceFmt(order.totalPrice),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            order.paymentMethod,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),

                // Expandable: Products list
                ExpansionTile(
                  initiallyExpanded: initiallyExpanded,
                  tilePadding: EdgeInsets.zero,
                  title: const Text(
                    'Products',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 8, top: 4),
                      child: Column(
                        children:
                            products.map((p) => _buildProductRow(p)).toList(),
                      ),
                    ),
                    const Divider(),
                    // Subtotal & totals
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          Text(_priceFmt(order.totalPrice)),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Shipping address
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.shippingAddressEntity.name ??
                                'No name provided',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.shippingAddressEntity.address ?? ''} ${order.shippingAddressEntity.addressDescription ?? ''}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'City: ${order.shippingAddressEntity.city ?? '—'} • Phone: ${order.shippingAddressEntity.phone ?? '—'}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Actions row
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // امكانية ربط حدث خارجي
                        },
                        child: const Text('View details'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // مثال: اعادة الطلب
                      },
                      child: const Text('Reorder'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
