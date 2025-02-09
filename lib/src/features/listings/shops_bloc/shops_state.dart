part of 'shops_bloc.dart';

@immutable
sealed class ShopsState {}

final class ShopsInitial extends ShopsState {}

final class ShopsLoading extends ShopsState {}

final class ShopsFailure extends ShopsState {
  final String message;

  ShopsFailure({required this.message});
}

final class ShopsSuccess extends ShopsState {
  final List<Shop> shops;
  ShopsSuccess({required this.shops});
}
