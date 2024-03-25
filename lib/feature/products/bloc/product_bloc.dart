import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_mobile_app/apis/products/add_product_api.dart';
import 'package:my_mobile_app/apis/products/delete_product_api.dart';
import 'package:my_mobile_app/apis/products/product_list_api.dart';
import 'package:my_mobile_app/apis/products/update_product_api.dart';
import 'package:my_mobile_app/common/enums/status.dart';
import 'package:my_mobile_app/common/models/pagination/pagination.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<GetProducts>(_getProducts);
    on<LoadMoreProducts>(_loadMoreProducts);
    on<AddProduct>(_addProduct);
    on<UpdateProduct>(_updateProduct);
    on<DeleteProduct>(_deleteProduct);
  }

  Future<void> _getProducts(GetProducts event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        status: event.status,
      ),
    );

    final res = await ProductListAPI.get(skip: event.skip);

    switch (res) {
      case Success(
          value: (
            final List<Product?> products,
            final Pagination pagination,
          )
        ):
        _updateProducts(
          products,
          pagination,
          emit,
          shouldClearList: event.skip == 0,
        );

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: Status.failure,
            error: error,
          ),
        );
    }
  }

  void _updateProducts(
    List<Product?> newProducts,
    Pagination newPagination,
    Emitter<ProductState> emit, {
    bool shouldClearList = false,
  }) {
    // clear existing booking data if [shouldClearBookings] is true
    // then add the new data from api to list
    final updatedList = [
      ...(shouldClearList ? <Product?>[] : state.products ??  <Product?>[]),
      ...newProducts,
    ];
    
    emit(
      state.copyWith(
        status: Status.success,
        products: updatedList,
        productPagination: newPagination,
      ),
    );
  }

  Future<void> _loadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (!state.productPagination!.canLoadMore) {
      return;
    }
    add(
      GetProducts(
        status: Status.loadingMore,
        skip: state.productPagination!.skip + state.productPagination!.limit,
      ),
    );
  }

  Future<void> _addProduct(AddProduct event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        status: Status.loading,
        actionType: ActionType.productFormAction,
      ),
    );

    final res = await AddProductAPI.post(title: event.title, description: event.description);

    switch (res) {
      case Success(value: final Product? product):
        emit(
          state.copyWith(
            status: Status.success,
            productFromApiRes: product,
          ),
        );

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: Status.failure,
            error: error,
          ),
        );
    }
  }

  Future<void> _updateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        status: Status.loading,
        actionType: ActionType.productFormAction,
      ),
    );

    final res = await UpdateProductAPI.put(
      id: event.id,
      title: event.title, 
      description: event.description,
    );

    switch (res) {
      case Success(value: final Product? product):
        emit(
          state.copyWith(
            status: Status.success,
            productFromApiRes: product,
          ),
        );

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: Status.failure,
            error: error,
          ),
        );
    }
  }

  Future<void> _deleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(
      state.copyWith(
        status: Status.loading,
        actionType: ActionType.productDetailsAction,
      ),
    );

    final res = await DeleteProductAPI.delete(id: event.id);

    switch (res) {
      case Success(value: final Product? product):
        emit(
          state.copyWith(
            status: Status.success,
            productFromApiRes: product,
          ),
        );

      case Failure(message: final String error):
        emit(
          state.copyWith(
            status: Status.failure,
            error: error,
          ),
        );
    }
  }
}
