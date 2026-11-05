import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookiaa/features/cart/data/models/cart_response.dart';
import 'package:bookiaa/features/cart/data/repo/cart_repo.dart';
import 'package:flutter/foundation.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartData? currentCart;
  int? updatingItemId;

  Future<void> getcartdata() async {
    emit(GetCartLoading());
    final response = await CartRepo.getCartData();
    if (response is CartData) {
      currentCart = response;
      emit(GetCartSuccsess(response));
    } else {
      emit(GetCartError(message: 'Failed to load your cart. Please try again.'));
    }
  }

  Future<void> updateItemQuantity({
    required int cartItemId,
    required int quantity,
  }) async {
    if (quantity < 1) {
      await removeItem(cartItemId);
      return;
    }

    updatingItemId = cartItemId;
    emit(CartItemUpdating(cartItemId: cartItemId, cartData: currentCart));

    final response = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    updatingItemId = null;

    if (response is CartData) {
      currentCart = response;
      emit(GetCartSuccsess(response));
    } else {
      emit(CartActionError(
        message: 'Could not update quantity. Please try again.',
        cartData: currentCart,
      ));
    }
  }

  Future<void> removeItem(int cartItemId) async {
    updatingItemId = cartItemId;
    emit(CartItemUpdating(cartItemId: cartItemId, cartData: currentCart));

    final response = await CartRepo.removeFromCart(cartItemId);
    updatingItemId = null;

    if (response is CartData) {
      currentCart = response;
      emit(CartActionSuccess(
        message: 'Item removed from cart.',
        cartData: response,
      ));
      emit(GetCartSuccsess(response));
    } else {
      emit(CartActionError(
        message: 'Could not remove item. Please try again.',
        cartData: currentCart,
      ));
    }
  }
}
