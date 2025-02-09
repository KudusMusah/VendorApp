part of 'products_bloc_bloc.dart';

@immutable
sealed class ProductsBlocEvent {}

final class GetAllProductsEvent extends ProductsBlocEvent {
  final String token;
  final String? shopId;

  GetAllProductsEvent({required this.token, this.shopId});
}
