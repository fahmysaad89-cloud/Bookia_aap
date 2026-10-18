part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginLogingStste extends AuthState {}

final class LoginSuccessStste extends AuthState {}

final class LoginErrorStste extends AuthState {}

final class RegisterLodingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {}
