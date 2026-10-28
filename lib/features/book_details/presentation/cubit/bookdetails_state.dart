part of 'bookdetails_cubit.dart';

@immutable
sealed class BookdetailsState {}

final class BookdetailsInitial extends BookdetailsState {}

final class GetDetailsError extends BookdetailsState {}

final class GetDetailsLoding extends BookdetailsState {}

final class GetDetailsSuccess extends BookdetailsState {
  final Data? details;
  GetDetailsSuccess(this.details);
}
