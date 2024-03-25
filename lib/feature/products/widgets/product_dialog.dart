import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/buttons/common_button.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';


class ProductDialog extends StatefulWidget {
  const ProductDialog({
    required this.title,
    required this.product,
    required this.onTapBtn,
    super.key,
  });

  final String title;
  final Product product;
  final VoidCallback onTapBtn;

  static Future<void> show({
    required String title,
    required Product product,
    required VoidCallback onTapBtn,
  }) async {
    final context = locator<NavigatorService>().mainContext;
    if (context == null) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (ctx) => ProductDialog(
        title: title,
        product: product,
        onTapBtn: onTapBtn,
      ),
    );
  }

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: PaddingUtils.paddingDialogLeftRight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: PaddingUtils.paddingContentDialog,
        horizontal: 0.03 * ScreenUtils.screenWidth,
      ),
      content: StatefulBuilder(
        builder: (dialogContext, StateSetter dialogSetState) {
          return Container(
            width: ScreenUtils.screenWidth,
            constraints: BoxConstraints(
              maxHeight: 0.75 * ScreenUtils.screenHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03 * ScreenUtils.screenWidth),
                  child: _headerView(),
                ),
                SizedBox(height: 0.015 * ScreenUtils.screenHeight),
                // Use Flexible here
                Flexible(
                  child: Scrollbar(
                    thickness: 6,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.03 * ScreenUtils.screenWidth),
                      child: SingleChildScrollView(
                        child: _contentView(dialogSetState),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0.03 * ScreenUtils.screenHeight),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.03 * ScreenUtils.screenWidth),
                  child: _actionButtons(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _headerView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: CustomTypography.h2,
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget _contentView(StateSetter dialogSetState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.product.title ?? '', style: CustomTypography.body2),
        Text(widget.product.description ?? '', style: CustomTypography.body2),
      ],
    );
  }

  Widget _actionButtons() {
    return CommonButton(
      title: LocaleKeys.default_dialog_ok_cta.tr(),
      onTap: () {
        Navigator.pop(context);
        widget.onTapBtn();
      },
      style: CommonButtonStyle.secondary,
      textStyle: CustomTypography.bodySubtitleSemiBold,
      columnCrossAxisAlignment: CrossAxisAlignment.center,
    );
  }
}
