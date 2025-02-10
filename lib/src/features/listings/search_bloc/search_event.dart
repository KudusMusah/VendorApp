part of 'search_bloc.dart';

@immutable
sealed class SearchProductBlocEvent {}

final class GetSearchProductEvent extends SearchProductBlocEvent {
  final String token;
  final String searchQuery;

  GetSearchProductEvent({required this.token, required this.searchQuery});
}

final class GetSellerProductEvent extends SearchProductBlocEvent {
  final String token;

  GetSellerProductEvent({required this.token});
}
