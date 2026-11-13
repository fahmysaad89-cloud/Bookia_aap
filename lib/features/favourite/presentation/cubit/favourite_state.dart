part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

final class GetFavouriteLoading extends FavouriteState {}

final class GetFavouriteSuccess extends FavouriteState {
  final List<Products> products;

  GetFavouriteSuccess(this.products);
}

final class GetFavouriteError extends FavouriteState {
  final String? message;

  GetFavouriteError({this.message});
}

final class RemoveFromFavouriteLoading extends FavouriteState {
  final int? productId;

  RemoveFromFavouriteLoading({this.productId});
}

final class RemoveFromFavouriteSuccess extends FavouriteState {
  final String message;
  final int? productId;

  RemoveFromFavouriteSuccess({required this.message, this.productId});
}

final class RemoveFromFavouriteError extends FavouriteState {
  final String message;
  final int? productId;

  RemoveFromFavouriteError({required this.message, this.productId});
}
