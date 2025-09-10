enum OrderStatus {
  pending('Pending', 'pending'),
  confirmed('Confirmed', 'confirmed'),
  processing('Processing', 'processing'),
  shipped('Shipped', 'shipped'),
  delivered('Delivered', 'delivered'),
  cancelled('Cancelled', 'cancelled'),
  returned('Returned', 'returned');

  const OrderStatus(this.displayName, this.value);

  final String displayName;
  final String value;

  static OrderStatus fromString(String status) {
    return OrderStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => OrderStatus.pending,
    );
  }
}
