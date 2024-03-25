import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mobile_app/common/enums/status.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/products/pages/product_form_page.dart';
import 'package:my_mobile_app/feature/products/widgets/product_list_body.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  static Future<void> goTo(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute<ProductPage>(
        builder: (context) => const ProductPage(),
      ),
    );
  }

  @override
  State<ProductPage> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const ProductEvent.getProducts(status: Status.loading, skip: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.pearl,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.calPolyGreen,
        onPressed: () => ProductFormPage.goTo(context),
        child: const Icon(Icons.add, color: Palette.mintCream),
      ),
      appBar: AppBar(
        title:
            Text(LocaleKeys.products.tr(), style: CustomTypography.body1Bold),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return ProductListBody(
            products: state.products ?? [],
            canLoadMore: state.productPagination?.canLoadMore ?? false,
          );
        },
      ),
    );
  }
}
