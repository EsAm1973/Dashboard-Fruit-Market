import 'package:flutter/material.dart';
import 'package:fruit_market_dashboard/features/orders/domain/entites/order_status.dart';

Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.indigo;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.returned:
        return Colors.grey;
    }
  }

  Color getStatusBackgroundColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange.shade50;
      case OrderStatus.confirmed:
        return Colors.blue.shade50;
      case OrderStatus.processing:
        return Colors.purple.shade50;
      case OrderStatus.shipped:
        return Colors.indigo.shade50;
      case OrderStatus.delivered:
        return Colors.green.shade50;
      case OrderStatus.cancelled:
        return Colors.red.shade50;
      case OrderStatus.returned:
        return Colors.grey.shade50;
    }
  }