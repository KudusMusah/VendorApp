import 'dart:convert';
import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'search_event.dart';
part 'search_state.dart';

class SearchProductBloc
    extends Bloc<SearchProductBlocEvent, SearchProductState> {
  SearchProductBloc() : super(SearchProductInitial()) {
    on<SearchProductBlocEvent>((event, emit) => emit(SearchProductLoading()));

    on<GetSearchProductEvent>(_onGetProductEvent);
    on<GetSellerProductEvent>(_onGetSellerProductEvent);
  }

  void _onGetProductEvent(
    GetSearchProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost:3000/api/products/search?query=${event.searchQuery}"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        String message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";

        if (response.statusCode >= 400) {
          message = "No products match your search";
        }
        emit(SearchProductFailure(message: message));
        return;
      }

      final resMap = jsonDecode(response.body);

      final List<Product> products = [];
      for (var product in resMap) {
        final a = Product(
          id: product['_id'],
          title: product['title'],
          description: product['description'],
          price: (product["price"] as num).toDouble(),
          imageUrl: product['imageUrl'],
          sellerId: product['sellerId'],
          shopId: product['shopId'],
          stockQuantity: product['stockQuantity'],
          createdAt: product['createdAt'],
          updatedAt: product['updatedAt'],
        );
        products.add(a);
      }
      emit(GetSearchProductSuccess(products: products));
    } catch (e) {
      emit(SearchProductFailure(message: "An unexpected error occured"));
    }
  }

  void _onGetSellerProductEvent(
    GetSellerProductEvent event,
    Emitter<SearchProductState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/products/seller"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;

        String message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";

        if (response.statusCode >= 400) {
          message = resMap["error"] ??
              resMap["message"] ??
              "No products found for this seller";
        }
        emit(SearchProductFailure(message: message));
        return;
      }

      final resMap = jsonDecode(response.body);

      final List<Product> products = [];
      for (var product in resMap) {
        final a = Product(
          id: product['_id'],
          title: product['title'],
          description: product['description'],
          price: (product["price"] as num).toDouble(),
          imageUrl: product['imageUrl'],
          sellerId: product['sellerId'],
          shopId: product['shopId'],
          stockQuantity: product['stockQuantity'],
          createdAt: product['createdAt'],
          updatedAt: product['updatedAt'],
        );
        products.add(a);
      }
      emit(GetSellerProductsSuccess(products: products));
    } catch (e) {
      emit(SearchProductFailure(message: "An unexpected error occured"));
    }
  }
}
