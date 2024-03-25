part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.getProducts({required Status status, required int skip}) = GetProducts;
  const factory ProductEvent.loadMoreProducts() = LoadMoreProducts;
  const factory ProductEvent.addProduct({required String title, required String description}) = AddProduct;
  const factory ProductEvent.updateProduct({required int id, required String title, required String description}) = UpdateProduct;
  const factory ProductEvent.deleteProduct({required int id}) = DeleteProduct;
}
