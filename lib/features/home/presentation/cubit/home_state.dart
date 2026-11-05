part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class GetBestSellerloding extends HomeState {}

final class GetBestSellerError extends HomeState {}

final class GetBestSellerSuccess extends HomeState {
  final List<Products>? products;
  GetBestSellerSuccess(this.products);
}

final class SearchLoading extends HomeState {}

final class SearchError extends HomeState {}

final class SearchSuccess extends HomeState {
  final List<Products>? products;
  SearchSuccess(this.products);
}

final class AddToCardSuccsess extends HomeState {
  final int? productId;
  AddToCardSuccsess({this.productId});
}

final class AddToCardError extends HomeState {
  final int? productId;
  final String? message;
  AddToCardError({this.productId, this.message});
}

final class AddToCardLoading extends HomeState {
  final int? productId;
  AddToCardLoading({this.productId});
}
