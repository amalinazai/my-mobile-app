import 'package:my_mobile_app/common/exceptions/network_exceptions.dart';
import 'package:my_mobile_app/common/models/pagination/pagination.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/network_service.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';

class ProductListAPI {
  static Future<Result<(List<Product?> products, Pagination pagination), String>> get({
    int? skip = 0,
  }) async {
    try {
      final response = await locator<NetworkService>().get(
        '/products',
        isRequireAuth: true,
        queryParams: {
          'skip': skip,
          'limit': 20,
        },
      ) as Map<String, dynamic>;

      final productListResponse = ProductListResponse.fromJson(response);

      return Success((productListResponse.products, productListResponse.pagination));
    } catch (e) {
      return Failure(
        getNetworkErrorMessage(
          e,
          badResponseMessage: (data) {
            return (data as Map<String, dynamic>?)?['userMessage'] as String?;
          },
        ),
      );
    }
  }
}

class ProductListResponse {

  ProductListResponse({
    required this.products,
    required this.pagination,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    final products = (json['products'] as List<dynamic>).map((item) {
      return Product.fromJson(item as Map<String, dynamic>);
    }).toList();
    
    final pagination = Pagination.fromJson(json);

    return ProductListResponse(
      products: products,
      pagination: pagination,
    );
  }
  final List<Product> products;
  final Pagination pagination;
}
