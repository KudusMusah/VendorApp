part of 'seller_shops_bloc.dart';

@immutable
sealed class SellerShopsEvent {}

final class SellerGetAllShops extends SellerShopsEvent {
  final String token;
  SellerGetAllShops({required this.token});
}
