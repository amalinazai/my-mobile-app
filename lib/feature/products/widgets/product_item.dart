import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/constants/asset_paths.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/feature/products/pages/product_details_page.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: PaddingUtils.paddingBottom),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.white,
          boxShadow: [
            BoxShadow(
              color: Palette.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Palette.black.withOpacity(0.2)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => ProductDetailsPage.goTo(context, product: product),
            splashColor: Palette.calPolyGreen.withOpacity(0.5),
            borderRadius: BorderRadius.circular(25),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnail!,
                    width: 0.3 * ScreenUtils.screenWidth,
                    height: 0.12 * ScreenUtils.screenHeight,
                    fit: BoxFit.cover,
                    // placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset(AssetPaths.placeholderImg),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(0.04 * ScreenUtils.screenWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(product.title ?? '', style: CustomTypography.body3Bold),
                        Text(
                          product.description ?? '', 
                          style: CustomTypography.body4, 
                          maxLines: 2, overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
