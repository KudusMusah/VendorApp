part of 'products_bloc_bloc.dart';

@immutable
sealed class DetailsProductsBlocEvent {}

final class GetDetailsProductEvent extends DetailsProductsBlocEvent {
  final String token;
  final String id;

  GetDetailsProductEvent({required this.token, required this.id});
}
