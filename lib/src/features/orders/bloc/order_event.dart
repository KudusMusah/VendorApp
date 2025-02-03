part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class CreateOrder extends OrderEvent {
  final List<Product> products;
  final List<int> qtys;
  final String token;
  final double totalPrice;

  CreateOrder({
    required this.products,
    required this.qtys,
    required this.token,
    required this.totalPrice,
  });
}

final class GetUserOrders extends OrderEvent {
  final String token;

  GetUserOrders({
    required this.token,
  });
}
