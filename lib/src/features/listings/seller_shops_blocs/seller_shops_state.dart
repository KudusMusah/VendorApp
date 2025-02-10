part of 'seller_shops_bloc.dart';

@immutable
sealed class SellerShopsState {}

final class SellerShopsInitial extends SellerShopsState {}

final class SellerShopsLoading extends SellerShopsState {}

final class SellerShopsFailure extends SellerShopsState {
  final String message;

  SellerShopsFailure({required this.message});
}

final class SellerShopsSuccess extends SellerShopsState {
  final List<Shop> shops;
  SellerShopsSuccess({required this.shops});
}
