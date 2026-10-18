import 'package:bloc/bloc.dart';
import 'package:bookiaa/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  login({required String email, required String password}) async {
    emit(LoginLogingStste());
    final Response = await AuthRepo.login(email: email, password: password);

    if (Response) {
      emit(LoginSuccessStste());
    } else {
      emit(LoginErrorStste());
    }
  }
}
