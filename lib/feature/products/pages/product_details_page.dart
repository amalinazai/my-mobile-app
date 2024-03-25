import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/enums/status.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/buttons/common_button.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/constants/asset_paths.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/feature/products/pages/product_form_page.dart';
import 'package:my_mobile_app/feature/products/widgets/product_dialog.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({required this.product, super.key});

  final Product product;

  static Future<void> goTo(
    BuildContext context, {
    required Product product,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute<ProductDetailsPage>(
        builder: (context) => ProductDetailsPage(product: product),
      ),
    );
  }

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mintCream,
      appBar: AppBar(
        title:
            Text(widget.product.title ?? '', style: CustomTypography.body1Bold),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (_, state) {
          if (state.actionType == ActionType.productDetailsAction) {
            switch (state.status) {
              case Status.loading:
                context.loaderOverlay.show();

              case Status.success:
                context.loaderOverlay.hide();
                ProductDialog.show(
                  title: LocaleKeys.product_deleted.tr(),
                  product: state.productFromApiRes ?? Product(),
                  onTapBtn: () {
                    Navigator.pop(context);
                  },
                );
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
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: PaddingUtils.paddingHorizontal,
                  vertical: PaddingUtils.paddingVertical,
                ),
                child: _mainContainer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _image(),
        Row(
          children: [
            _smallTag(widget.product.brand ?? '', Palette.calPolyGreen),
            _smallTag(widget.product.category ?? '', Palette.olivine),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: PaddingUtils.paddingVerticalService,),
          child: Text(widget.product.title ?? '', style: CustomTypography.h3),
        ),
        Text(widget.product.description ?? '', style: CustomTypography.body1),
        const Spacer(),
        _editDeleteBtn(),
      ],
    );
  }

  Widget _image() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: PaddingUtils.paddingVertical),
      child: CachedNetworkImage(
        imageUrl: widget.product.thumbnail!,
        width: ScreenUtils.screenWidth,
        height: 0.2 * ScreenUtils.screenHeight,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset(AssetPaths.placeholderImg),
      ),
    );
  }

  Widget _smallTag(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(title,
          style: CustomTypography.body3Bold.copyWith(color: Palette.white),),
    );
  }

  Widget _editDeleteBtn() {
    return Padding(
      padding: EdgeInsets.all(0.02 * ScreenUtils.screenHeight),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: ScreenUtils.screenWidth * 0.05,
              ),
              child: CommonButton(
                title: '',
                onTap: () => context.read<ProductBloc>().add(ProductEvent.deleteProduct(id: widget.product.id ?? 0)),
                style: CommonButtonStyle.secondary,
                textStyle: CustomTypography.body1Bold,
                customColor: Palette.error,
                customLeftIcon: Image.asset(
                  AssetPaths.trashRed,
                  width: ScreenUtils.screenWidth * 0.08,
                  gaplessPlayback: true,
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtils.screenWidth * 0.51,
            child: CommonButton(
              title: LocaleKeys.update.tr(),
              style: CommonButtonStyle.primary,
              onTap: () =>
                  ProductFormPage.goTo(context, product: widget.product),
              textStyle: CustomTypography.h4,
              columnCrossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
