import 'package:bookiaa/core/networking/api_error_handler.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getsellerbooks() async {
    emit(GetBestSellerloding());
    try {
      final response = await HomeRepo.getBestSellerBooks();
      if (response is booksmodels) {
        emit(GetBestSellerSuccess(response.data?.products));
      } else {
        emit(GetBestSellerError(
          message: 'Failed to load books. Please try again.',
        ));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(GetBestSellerError(message: error));
    } catch (e) {
      emit(GetBestSellerError(
        message: 'Something went wrong. Please try again.',
      ));
    }
  }

  void search(String text) async {
    emit(SearchLoading());
    try {
      final data = await HomeRepo.search(text);
      if (data is List<Products>) {
        emit(SearchSuccess(data));
      } else {
        emit(SearchError(message: 'Failed to find books.'));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(SearchError(message: error));
    } catch (e) {
      emit(SearchError(
        message: 'Something went wrong. Please try again.',
      ));
    }
  }

  void AddToCart(int productId) async {
    emit(AddToCardLoading(productId: productId));
    try {
      final response = await HomeRepo.addtocart(productId);
      if (response == true) {
        emit(AddToCardSuccsess(productId: productId));
      } else {
        emit(AddToCardError(
          productId: productId,
          message: "Failed to add product to cart",
        ));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(AddToCardError(
        productId: productId,
        message: error,
      ));
    } catch (e) {
      emit(AddToCardError(
        productId: productId,
        message: "Something went wrong. Please try again.",
      ));
    }
  }
}
