part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartFailure extends CartState {
  final String message;

  CartFailure({required this.message});
}

final class GetCartProductsSuccess extends CartState {
  final List<Product> products;
  final List<int> qtys;

  GetCartProductsSuccess({required this.products, required this.qtys});
}
