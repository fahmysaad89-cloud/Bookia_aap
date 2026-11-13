import 'package:bookiaa/core/networking/api_error_handler.dart';
import 'package:bookiaa/features/favourite/data/repo/favourite_repo.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  List<Products> favourites = [];
  final Set<int> favouriteIds = {};

  bool isFavourite(int? productId) {
    if (productId == null) return false;
    return favouriteIds.contains(productId);
  }

  void _syncIds() {
    favouriteIds.clear();
    for (final p in favourites) {
      if (p.id != null) {
        favouriteIds.add(p.id!);
      }
    }
  }

  Future<void> getFavourites() async {
    emit(GetFavouriteLoading());
    try {
      final response = await FavouriteRepo.getFavourites();
      if (response != null) {
        favourites = List.from(response);
        _syncIds();
        emit(GetFavouriteSuccess(favourites));
      } else {
        emit(GetFavouriteError(message: 'Failed to load favorite books.'));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(GetFavouriteError(message: error));
    } catch (e) {
      emit(GetFavouriteError(
        message: 'Something went wrong. Please try again.',
      ));
    }
  }

  Future<void> removeFromFavourite(int productId) async {
    emit(RemoveFromFavouriteLoading(productId: productId));
    try {
      final success = await FavouriteRepo.removeFromFavourite(productId);
      if (success) {
        favourites.removeWhere((item) => item.id == productId);
        _syncIds();
        emit(RemoveFromFavouriteSuccess(
          message: 'Book removed from favorites.',
          productId: productId,
        ));
        emit(GetFavouriteSuccess(favourites));
      } else {
        emit(RemoveFromFavouriteError(
          message: 'Failed to remove from favorites.',
          productId: productId,
        ));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(RemoveFromFavouriteError(message: error, productId: productId));
    } catch (e) {
      emit(RemoveFromFavouriteError(
        message: 'Something went wrong. Please try again.',
        productId: productId,
      ));
    }
  }

  Future<void> toggleFavourite(Products product) async {
    final productId = product.id;
    if (productId == null) return;

    final currentlySaved = isFavourite(productId);
    emit(RemoveFromFavouriteLoading(productId: productId));

    try {
      if (currentlySaved) {
        final success = await FavouriteRepo.removeFromFavourite(productId);
        if (success) {
          favourites.removeWhere((item) => item.id == productId);
          _syncIds();
          emit(RemoveFromFavouriteSuccess(
            message: 'Book removed from favorites.',
            productId: productId,
          ));
          emit(GetFavouriteSuccess(favourites));
        } else {
          emit(RemoveFromFavouriteError(
            message: 'Failed to remove from favorites.',
            productId: productId,
          ));
        }
      } else {
        final success = await FavouriteRepo.addToFavourite(productId);
        if (success) {
          if (!favourites.any((item) => item.id == productId)) {
            favourites.add(product);
          }
          _syncIds();
          emit(RemoveFromFavouriteSuccess(
            message: 'Book added to favorites!',
            productId: productId,
          ));
          emit(GetFavouriteSuccess(favourites));
        } else {
          emit(RemoveFromFavouriteError(
            message: 'Failed to add to favorites.',
            productId: productId,
          ));
        }
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(RemoveFromFavouriteError(message: error, productId: productId));
    } catch (e) {
      emit(RemoveFromFavouriteError(
        message: 'Something went wrong. Please try again.',
        productId: productId,
      ));
    }
  }
}
