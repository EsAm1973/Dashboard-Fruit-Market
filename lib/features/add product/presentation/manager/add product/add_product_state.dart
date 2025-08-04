part of 'add_product_cubit.dart';

@immutable
sealed class AddProductState {}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductError extends AddProductState {
  final String error;
  AddProductError({required this.error});
}

final class AddProductSuccess extends AddProductState {}
