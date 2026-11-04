import 'package:bloc/bloc.dart';
import 'package:bookiaa/features/profile/data/models/profile_response.dart';
import 'package:bookiaa/features/profile/data/repo/profile_repo.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Getprofiledata() async {
    emit(GetProfileLoading());
    final Response = await ProfileRepo.getProfileData();
    if (Response is ProfileData) {
      emit(GetProfileSuccess(Response));
    } else {
      emit(GetProfileError());
    }
  }
}
