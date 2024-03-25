import 'package:my_mobile_app/common/exceptions/network_exceptions.dart';
import 'package:my_mobile_app/common/models/result.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/network_service.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';

class UpdateProductAPI {
  static Future<Result<Product, String>> put({
    required int id,
    required String title,
    required String description,
  }) async {
    try {
      final response = await locator<NetworkService>().put(
        '/products/$id',
        isRequireAuth: false,
        body: {
          'title': title,
          'description': description,
        },
      ) as Map<String, dynamic>;

      // Directly parse the API response into UpdateProductResponse
      final addProductRes = UpdateProductResponse.fromJson(response);

      return Success(addProductRes.product);
    } catch (e) {
      return Failure(
        getNetworkErrorMessage(
          e,
          badResponseMessage: (data) {
            return (data as Map<String, dynamic>?)?['message'] as String?;
          },
        ),
      );
    }
  }
}

class UpdateProductResponse {
  UpdateProductResponse({required this.product});

  factory UpdateProductResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProductResponse(
      product: Product.fromJson(json),
    );
  }
  final Product product;
}
