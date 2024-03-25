import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/pagination/common_pagination_footer.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/feature/products/widgets/product_item.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    required this.products,
    required this.onRefresh,
    required this.scrollController,
    required this.canLoadMore,
    super.key,
  });

  final List<Product?> products;
  final bool canLoadMore;
  final Future<void> Function() onRefresh;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: products.isEmpty
              ? SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: ScreenUtils.contentableHeight,
                    child: const Placeholder(),
                  ),
                )
              : ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                  itemCount: products.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    if (index == products.length) {
                      return CommonPaginationFooter(
                        hasMoreData: canLoadMore,
                      );
                    }

                    return ProductItem(product: products[index] ?? Product());
                  },
                ),
        );
      },
    );
  }
}
