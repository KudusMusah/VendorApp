import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBloc extends Bloc<CartBlocEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartBlocEvent>((event, emit) => emit(CartLoading()));

    on<AddToCartEvent>(_onAddoCartEvent);
    on<GetCartProductsEvent>(_onGetCartProductsEvent);
  }

  void _onAddoCartEvent(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final hiveBox = Hive.box(name: "store");
      final List<Product> products = [];
      final List<int> qtys = [];

      hiveBox.read(() {
        for (int i = 0; i < hiveBox.length; i++) {
          final a = hiveBox.get("store $i");
          if (a == null) {
            break;
          }
          if (Product.fromJson(a).id != event.product.id) {
            products.add(Product.fromJson(a));
            qtys.add(hiveBox.get("store_qty $i"));
          }
        }
      });

      products.add(event.product);
      qtys.add(event.qty);

      hiveBox.write(() {
        for (int i = 0; i < products.length; i++) {
          hiveBox.put("store $i", products[i].toJson());
          hiveBox.put("store_qty $i", qtys[i]);
        }
      });
      emit(GetCartProductsSuccess(products: products, qtys: qtys));
    } catch (e) {
      emit(CartFailure(message: e.toString()));
    }
  }

  void _onGetCartProductsEvent(
    GetCartProductsEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      final hiveBox = Hive.box(name: "store");
      final List<Product> products = [];
      final List<int> qtys = [];

      hiveBox.read(() {
        for (int i = 0; i < hiveBox.length; i++) {
          final a = hiveBox.get("store $i");
          if (a == null) {
            break;
          }
          products.add(Product.fromJson(a));
          qtys.add(hiveBox.get("store_qty $i"));
        }
      });

      emit(GetCartProductsSuccess(products: products, qtys: qtys));
    } catch (e) {
      emit(CartFailure(message: e.toString()));
    }
  }
}
