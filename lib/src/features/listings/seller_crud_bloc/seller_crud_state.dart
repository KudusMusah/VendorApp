part of 'seller_crud_bloc.dart';

@immutable
sealed class SellerCrudState {}

final class SellerCrudInitial extends SellerCrudState {}

final class SellerCrudLoading extends SellerCrudState {}

final class SellerCrudFailure extends SellerCrudState {
  final String message;

  SellerCrudFailure({required this.message});
}

final class SellerAddProductsState extends SellerCrudState {}

final class SellerEditProductsState extends SellerCrudState {}

final class SellerDeleteProductsState extends SellerCrudState {}
