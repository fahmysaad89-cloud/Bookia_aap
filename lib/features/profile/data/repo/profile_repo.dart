import 'package:bookiaa/core/networking/api_endpoint.dart';
import 'package:bookiaa/core/networking/dio_factory.dart';
import 'package:bookiaa/features/profile/data/models/profile_response.dart';

class ProfileRepo {
  static Future<ProfileData?> getProfileData() async {
    try {
      final response = await DioFactory.dio?.get(ApiEndpoint.profile);

      if (response?.statusCode == 200) {
        final ProfileResponse profileData = ProfileResponse.fromJson(
          response?.data,
        );
        return profileData.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
