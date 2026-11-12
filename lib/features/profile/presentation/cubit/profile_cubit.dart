import 'package:bookiaa/core/networking/api_error_handler.dart';
import 'package:bookiaa/features/profile/data/models/profile_response.dart';
import 'package:bookiaa/features/profile/data/repo/profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> Getprofiledata() async {
    emit(GetProfileLoading());
    try {
      final response = await ProfileRepo.getProfileData();
      if (response is ProfileData) {
        emit(GetProfileSuccess(response));
      } else {
        emit(GetProfileError(error: 'Failed to load profile data.'));
      }
    } on DioException catch (e) {
      final error = ApiErrorHandler.handleDioException(e);
      emit(GetProfileError(error: error));
    } catch (e) {
      emit(GetProfileError(error: e.toString()));
    }
  }
}
