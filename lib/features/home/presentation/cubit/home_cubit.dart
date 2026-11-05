import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/data/repo/home_repo.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getsellerbooks() async {
    emit(GetBestSellerloding());
    final response = await HomeRepo.getBestSellerBooks();
    if (response is booksmodels) {
      emit(GetBestSellerSuccess(response.data?.products));
    } else {
      emit(GetBestSellerError());
    }
  }

  void search(String text) async {
    emit(SearchLoading());
    final data = await HomeRepo.search(text);
    if (data is List<Products>) {
      emit(SearchSuccess(data));
    } else {
      emit(SearchError());
    }
  }

  void AddToCart(int productId) async {
    emit(AddToCardLoading(productId: productId));
    final response = await HomeRepo.addtocart(productId);
    if (response == true) {
      emit(AddToCardSuccsess(productId: productId));
    } else {
      emit(AddToCardError(
        productId: productId,
        message: "Failed to add product to cart",
      ));
    }
  }
}
