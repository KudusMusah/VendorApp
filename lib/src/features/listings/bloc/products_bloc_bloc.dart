import 'dart:convert';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'products_bloc_event.dart';
part 'products_bloc_state.dart';

class ProductsBloc extends Bloc<ProductsBlocEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsBlocEvent>((event, emit) => emit(ProductsLoading()));

    on<GetAllProductsEvent>(_onGetAllProductsEvent);
  }

  void _onGetAllProductsEvent(
    GetAllProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/products/"),
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
        emit(ProductsFailure(message: message));
        return;
      }

      final resMap = jsonDecode(response.body);

      final List<Product> products = [];
      for (var product in resMap) {
        final a = Product(
          id: product['_id'],
          title: product['title'],
          description: product['description'],
          price: product['price'],
          imageUrl: product['imageUrl'],
          sellerId: product['sellerId'],
          shopId: product['shopId'],
          stockQuantity: product['stockQuantity'],
          createdAt: product['createdAt'],
          updatedAt: product['updatedAt'],
        );
        products.add(a);
      }

      emit(GetAllProductsSuccess(products: products));
    } catch (e) {
      emit(ProductsFailure(message: "An unexpected error occured"));
    }
  }
}
