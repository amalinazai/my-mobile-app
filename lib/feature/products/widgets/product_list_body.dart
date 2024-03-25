import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/enums/status.dart';
import 'package:my_mobile_app/common/extensions/widgets/scroll_controller.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/feature/products/widgets/product_list_view.dart';

class ProductListBody extends StatefulWidget {
  const ProductListBody({
    required this.products,
    this.canLoadMore = false,
    super.key,
  });

  final List<Product?> products;
  final bool canLoadMore;

  @override
  State<ProductListBody> createState() => _ProductListBodyState();
}

class _ProductListBodyState extends State<ProductListBody> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // setup scroll controller listeners
    scrollController.addListener(_addOnLoadMoreListener);
  }

  @override
  void dispose() {
    super.dispose();

    scrollController
      ..removeListener(_addOnLoadMoreListener)
      ..dispose();
  }

  void _addOnLoadMoreListener() {
    if (scrollController.isScrollToEnd) {
      context.read<ProductBloc>().add(const LoadMoreProducts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (_, state) {
        switch (state.status) {
          case Status.loading:
            context.loaderOverlay.show();

          case Status.success:
            context.loaderOverlay.hide();
            // ignore: unnecessary_breaks
            break;

          case Status.failure:
            context.loaderOverlay.hide();
            CommonSnackbar.show(
              title: state.error ?? '',
              isSuccess: false,
            );
          // ignore: no_default_cases
          default:
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.04 * ScreenUtils.screenWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: ProductListView(
                products: widget.products,
                onRefresh: () async => context
                    .read<ProductBloc>()
                    .add(const GetProducts(status: Status.loading, skip: 0)),
                scrollController: scrollController,
                canLoadMore: widget.canLoadMore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
