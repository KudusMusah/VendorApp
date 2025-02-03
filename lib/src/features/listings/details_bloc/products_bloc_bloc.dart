import 'dart:convert';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'products_bloc_event.dart';
part 'products_bloc_state.dart';

class DetailsProductsBloc
    extends Bloc<DetailsProductsBlocEvent, DetailsProductsState> {
  DetailsProductsBloc() : super(DetailsProductsInitial()) {
    on<DetailsProductsBlocEvent>(
        (event, emit) => emit(DetailsProductsLoading()));

    on<GetDetailsProductEvent>(_onGetProductEvent);
  }

  void _onGetProductEvent(
    GetDetailsProductEvent event,
    Emitter<DetailsProductsState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/products/product/${event.id}"),
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
        emit(DetailsProductsFailure(message: message));
        return;
      }

      final resMap = jsonDecode(response.body);

      final product = Product(
        id: resMap['_id'],
        title: resMap['title'],
        description: resMap['description'],
        price: resMap['price'],
        imageUrl: resMap['imageUrl'],
        sellerId: resMap['sellerId'],
        shopId: resMap['shopId'],
        stockQuantity: resMap['stockQuantity'],
        createdAt: resMap['createdAt'],
        updatedAt: resMap['updatedAt'],
      );

      emit(GetDetailsProductSuccess(product: product));
    } catch (e) {
      emit(DetailsProductsFailure(message: "An unexpected error occured"));
    }
  }
}
