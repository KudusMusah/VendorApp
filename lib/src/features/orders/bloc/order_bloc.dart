import 'dart:convert';

import 'package:didi/src/features/listings/models/products.dart';
import 'package:didi/src/features/orders/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) => emit(OrderLoading()));

    on<CreateOrder>(_onCreateOrderEvent);
    on<GetUserOrders>(_onGetUserOrders);
  }

  void _onCreateOrderEvent(
    CreateOrder event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final List<Map<String, dynamic>> products = [];
      final List<String> sellerIds = [];
      for (int i = 0; i < event.products.length; i++) {
        final product = {
          "productId": event.products[i].id,
          "quantity": event.qtys[i],
          "price": event.products[i].price,
        };
        products.add(product);
        sellerIds.add(event.products[i].sellerId);
      }

      final Map<String, dynamic> orderData = {
        "sellerIds": sellerIds,
        "products": products,
        "totalPrice": double.parse(event.totalPrice.toStringAsFixed(2)),
      };

      final response = await http.post(
        Uri.parse("http://localhost:3000/api/orders"),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${event.token}",
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode != 201) {
        final resMap = jsonDecode(response.body) as Map<String, dynamic>;
        final message = resMap["error"] ??
            resMap["message"] ??
            "An unexpected error occured";
        emit(OrderFailure(message: message));
        return;
      }

      final hiveBox = Hive.box(name: "store");
      hiveBox.clear();
      emit(OrderSuccess());
    } catch (e) {
      emit(OrderFailure(message: "An unexpected error occured"));
    }
  }

  void _onGetUserOrders(
    GetUserOrders event,
    Emitter<OrderState> emit,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost:3000/api/orders"),
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
        emit(OrderFailure(message: message));
        return;
      }

      final res = jsonDecode(response.body);
      final List<MyOrderItem> orders = [];

      for (int i = 0; i < res.length; i++) {
        final a = MyOrderItem.fromJson(res[i]);
        orders.add(a);
      }
      emit(GetUserOrdersSuccess(orders: orders));
    } catch (e) {
      emit(OrderFailure(message: "An unexpected error occured"));
    }
  }
}
