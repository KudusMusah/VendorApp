import 'package:didi/src/features/listings/models/shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  ShopsBloc() : super(ShopsInitial()) {
    on<ShopsEvent>((event, emit) => emit(ShopsLoading()));

    on<GetAllShops>(_onRemoveFromCart);
  }

  void _onRemoveFromCart(
    GetAllShops event,
    Emitter<ShopsState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/products/shops"),
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
        emit(ShopsFailure(message: message));
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
      emit(ShopsSuccess(shops: shops));
    } catch (e) {
      emit(ShopsFailure(message: e.toString()));
    }
  }
}
