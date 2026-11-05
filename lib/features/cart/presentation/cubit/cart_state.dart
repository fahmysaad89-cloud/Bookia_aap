part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoading extends CartState {}

final class GetCartSuccsess extends CartState {
  final CartData? cartData;
  GetCartSuccsess(this.cartData);
}

final class GetCartError extends CartState {
  final String? message;
  GetCartError({this.message});
}

final class CartItemUpdating extends CartState {
  final int cartItemId;
  final CartData? cartData;
  CartItemUpdating({required this.cartItemId, this.cartData});
}

final class CartActionSuccess extends CartState {
  final String message;
  final CartData? cartData;
  CartActionSuccess({required this.message, this.cartData});
}

final class CartActionError extends CartState {
  final String message;
  final CartData? cartData;
  CartActionError({required this.message, this.cartData});
}
