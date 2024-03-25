part of 'product_bloc.dart';

enum ActionType { productDetailsAction, productFormAction }

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(Status.initial) Status status,
    String? successMessage,
    String? error,
    List<Product?>? products,
    Pagination? productPagination,
    Product? productFromApiRes,
    ActionType? actionType,
  }) = _ProductState;
}
