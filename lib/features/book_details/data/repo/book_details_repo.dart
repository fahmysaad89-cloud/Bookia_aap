import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/book_details/data/models/book_details_model.dart';

class BookDetailsRepo {
  static Future<Bookdetails?> getbookdetails(int id) async {
    try {
      final response = await DioFactory.dio?.get(
        "${ApiEndpoint.bookDetails}$id",
      );
      if (response?.statusCode == 200) {
        Bookdetails details = Bookdetails.fromJson(response?.data);
        return details;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
