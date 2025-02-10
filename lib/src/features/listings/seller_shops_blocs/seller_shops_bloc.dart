import 'package:didi/src/features/listings/models/shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'seller_shops_event.dart';
part 'seller_shops_state.dart';

class SellerShopsBloc extends Bloc<SellerShopsEvent, SellerShopsState> {
  SellerShopsBloc() : super(SellerShopsInitial()) {
    on<SellerShopsEvent>((event, emit) => emit(SellerShopsLoading()));

    on<SellerGetAllShops>(_onRemoveFromCart);
  }

  void _onRemoveFromCart(
    SellerGetAllShops event,
    Emitter<SellerShopsState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/products/shops/seller"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        final message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";
        emit(SellerShopsFailure(message: message));
        return;
      }

      final resMap = jsonDecode(response.body);

      final List<Shop> shops = [];
      for (var shop in resMap) {
        final a = Shop(
          id: shop['_id'] ?? "",
          name: shop['name'] ?? "",
          description: shop['description'] ?? "",
          sellerId: shop["price"] ?? "",
          createdAt: shop['imageUrl'] ?? "",
          updatedAt: shop['sellerId'] ?? "",
        );
        shops.add(a);
      }
      emit(SellerShopsSuccess(shops: shops));
    } catch (e) {
      emit(SellerShopsFailure(message: e.toString()));
    }
  }
}
