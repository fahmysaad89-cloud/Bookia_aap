import 'package:bloc/bloc.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/data/repo/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  getsellerbooks() async {
    emit(GetBestSellerloding());
    final Response = await HomeRepo.getBestSellerBooks();
    if (Response is booksmodels) {
      emit(GetBestSellerSuccess(Response.data?.products));
    } else {
      emit(GetBestSellerError());
    }
  }
}
