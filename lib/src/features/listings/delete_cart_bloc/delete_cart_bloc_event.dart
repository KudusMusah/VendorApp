part of 'delete_cart_bloc_bloc.dart';

@immutable
sealed class DeleteCartBlocEvent {}

final class RemoveFromCart extends DeleteCartBlocEvent {
  final Product product;

  RemoveFromCart({required this.product});
}
