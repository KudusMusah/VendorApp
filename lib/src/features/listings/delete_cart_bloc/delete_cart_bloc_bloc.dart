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
      int? index;

      hiveBox.read(() {
        for (int i = 0; i < hiveBox.length; i++) {
          final a = hiveBox.get("store $i");

          if (Product.fromJson(a) == event.product) {
            index = i;
            break;
          }
        }
      });

      if (index != null) {
        hiveBox.delete("store $index");
        emit(DeleteCartSuccess());
      }
    } catch (e) {
      emit(DeleteCartFailure(message: e.toString()));
    }
  }
}
