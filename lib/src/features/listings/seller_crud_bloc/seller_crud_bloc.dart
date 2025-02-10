import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'dart:convert';

part 'seller_crud_event.dart';
part 'seller_crud_state.dart';

class SellerCrudBloc extends Bloc<SellerCrudEvent, SellerCrudState> {
  SellerCrudBloc() : super(SellerCrudInitial()) {
    on<SellerCrudEvent>((event, emit) => emit(SellerCrudLoading()));

    on<SellerAddProducts>(_onCreateProduct);
    on<SellerEditProducts>(_onEditProduct);
    on<SellerDeleteProducts>(_onDeleteProduct);
  }

  void _onCreateProduct(
    SellerAddProducts event,
    Emitter<SellerCrudState> emit,
  ) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://localhost:3000/api/products"),
      );

      // Add headers (Authorization)
      request.headers['Authorization'] = "Bearer ${event.token}";

      // Add text fields
      request.fields['title'] = event.title;
      request.fields['description'] = event.description;
      request.fields['price'] = event.price.toString();
      request.fields['stockQuantity'] = event.stockQuantity.toString();
      request.fields['shopId'] = event.shopId;

      // Attach image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'image', // Matches backend field name
          event.image.path,
          filename: basename(event.image.path),
          contentType: MediaType('image', 'jpeg'), // Adjust based on image type
        ),
      );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        emit(SellerAddProductsState());
      } else {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;
        final message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occurred";
        emit(SellerCrudFailure(message: message));
      }
    } catch (e) {
      emit(SellerCrudFailure(message: e.toString()));
    }
  }

  void _onEditProduct(
    SellerEditProducts event,
    Emitter<SellerCrudState> emit,
  ) async {
    try {
      final Map<String, dynamic> orderData = {
        "title": event.title,
        "description": event.description,
        "price": double.parse(event.price.toStringAsFixed(2)),
        "stockQuantity": event.stockQuantity,
        "shopId": event.shopId,
      };

      final response = await http.put(
        Uri.parse(
            "http://localhost:3000/api/products/product/${event.productId}"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;
        final message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";

        emit(SellerCrudFailure(message: message));
        return;
      }
      emit(SellerAddProductsState());
    } catch (e) {
      emit(SellerCrudFailure(message: e.toString()));
    }
  }

  void _onDeleteProduct(
    SellerDeleteProducts event,
    Emitter<SellerCrudState> emit,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse(
            "http://localhost:3000/api/products/product/${event.productId}"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
      );

      print(response.body);

      if (response.statusCode != 200) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;
        final message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";

        emit(SellerCrudFailure(message: message));
        return;
      }
      emit(SellerAddProductsState());
    } catch (e) {
      emit(SellerCrudFailure(message: e.toString()));
    }
  }
}
