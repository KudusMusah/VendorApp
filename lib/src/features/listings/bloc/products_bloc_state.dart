part of 'products_bloc_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsFailure extends ProductsState {
  final String message;

  ProductsFailure({required this.message});
}

final class GetAllProductsSuccess extends ProductsState {
  final List<Product> products;

  GetAllProductsSuccess({required this.products});
}