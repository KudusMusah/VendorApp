part of 'delete_cart_bloc_bloc.dart';

@immutable
sealed class DeleteCartState {}

final class DeleteCartInitial extends DeleteCartState {}

final class DeleteCartLoading extends DeleteCartState {}

final class DeleteCartFailure extends DeleteCartState {
  final String message;

  DeleteCartFailure({required this.message});
}

final class DeleteCartSuccess extends DeleteCartState {}
