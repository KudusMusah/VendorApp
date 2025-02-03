part of 'products_bloc_bloc.dart';

@immutable
sealed class DetailsProductsState {}

final class DetailsProductsInitial extends DetailsProductsState {}

final class DetailsProductsLoading extends DetailsProductsState {}

final class DetailsProductsFailure extends DetailsProductsState {
  final String message;

  DetailsProductsFailure({required this.message});
}

final class GetDetailsProductSuccess extends DetailsProductsState {
  final Product product;

  GetDetailsProductSuccess({required this.product});
}
