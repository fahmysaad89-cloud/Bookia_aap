import 'package:bookiaa/features/book_details/data/models/book_details_model.dart';
import 'package:bookiaa/features/book_details/data/repo/book_details_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bookdetails_state.dart';

class BookdetailsCubit extends Cubit<BookdetailsState> {
  BookdetailsCubit() : super(BookdetailsInitial());

  Future<void> getdetails(int id) async {
    emit(GetDetailsLoding());
    final details = await BookDetailsRepo.getbookdetails(id);
    if (details is Bookdetails) {
      emit(GetDetailsSuccess(details.data));
    } else {
      emit(GetDetailsError());
    }
  }
}
