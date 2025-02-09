import 'package:didi/src/features/listings/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'delete_cart_bloc_event.dart';
part 'delete_cart_bloc_state.dart';

class DeleteCartBloc extends Bloc<DeleteCartBlocEvent, DeleteCartState> {
  DeleteCartBloc() : super(DeleteCartInitial()) {
    on<DeleteCartBlocEvent>((event, emit) => emit(DeleteCartLoading()));

    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<DeleteCartState> emit,
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

          if (Product.fromJson(a) != event.product) {
            products.add(Product.fromJson(a));
            qtys.add(hiveBox.get("store_qty $i"));
          }
        }
      });

      hiveBox.clear();
      hiveBox.write(() {
        for (int i = 0; i < products.length; i++) {
          hiveBox.put("store $i", products[i].toJson());
          hiveBox.put("store_qty $i", qtys[i]);
        }
      });
    } catch (e) {
      emit(DeleteCartFailure(message: e.toString()));
    }
  }
}
