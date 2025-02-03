part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartBlocEvent {}

final class AddToCartEvent extends CartBlocEvent {
  final Product product;
  final int qty;

  AddToCartEvent({required this.product, required this.qty});
}

final class GetCartProductsEvent extends CartBlocEvent {}
