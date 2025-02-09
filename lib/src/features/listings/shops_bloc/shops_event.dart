part of 'shops_bloc.dart';

@immutable
sealed class ShopsEvent {}

final class GetAllShops extends ShopsEvent {
  final String token;
  GetAllShops({required this.token});
}
