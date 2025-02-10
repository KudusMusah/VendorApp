part of 'search_bloc.dart';

@immutable
sealed class SearchProductState {}

final class SearchProductInitial extends SearchProductState {}

final class SearchProductLoading extends SearchProductState {}

final class SearchProductFailure extends SearchProductState {
  final String message;

  SearchProductFailure({required this.message});
}

final class GetSearchProductSuccess extends SearchProductState {
  final List<Product> products;

  GetSearchProductSuccess({required this.products});
}

final class GetSellerProductsSuccess extends SearchProductState {
  final List<Product> products;

  GetSellerProductsSuccess({required this.products});
}
