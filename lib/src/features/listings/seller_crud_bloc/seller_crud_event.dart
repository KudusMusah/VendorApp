part of 'seller_crud_bloc.dart';

@immutable
sealed class SellerCrudEvent {}

final class SellerAddProducts extends SellerCrudEvent {
  final String token;
  final String title;
  final String description;
  final double price;
  final int stockQuantity;
  final File image;
  final String shopId;

  SellerAddProducts({
    required this.token,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.shopId,
    required this.stockQuantity,
  });
}

final class SellerEditProducts extends SellerCrudEvent {
  final String token;
  final String title;
  final String description;
  final double price;
  final int stockQuantity;
  final String shopId;
  final String productId;

  SellerEditProducts({
    required this.token,
    required this.title,
    required this.description,
    required this.price,
    required this.shopId,
    required this.stockQuantity,
    required this.productId,
  });
}

final class SellerDeleteProducts extends SellerCrudEvent {
  final String productId;
  final String token;

  SellerDeleteProducts({
    required this.productId,
    required this.token,
  });
}
