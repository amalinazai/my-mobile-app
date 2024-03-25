import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/enums/input_state.dart';
import 'package:my_mobile_app/common/enums/status.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/widgets/buttons/common_button.dart';
import 'package:my_mobile_app/common/widgets/input/common_text_field.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/products/models/product_model.dart';
import 'package:my_mobile_app/feature/products/widgets/product_dialog.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({
    this.product,
    super.key,
  });

  final Product? product;

  static Future<void> goTo(BuildContext context, {Product? product}) async {
    await Navigator.of(context).push(
      MaterialPageRoute<ProductFormPage>(
        builder: (context) => ProductFormPage(product: product),
      ),
    );
  }

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController titleTEC = TextEditingController();
  final TextEditingController descTEC = TextEditingController();
  bool isTFFilledIn = false;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      titleTEC.text = widget.product?.title ?? '';
      descTEC.text = widget.product?.description ?? '';
      isTFFilledIn = true;
    }

    titleTEC.addListener(_textFieldListener);
    descTEC.addListener(_textFieldListener);
  }

  @override
  void dispose() {
    titleTEC
      ..removeListener(_textFieldListener)
      ..dispose();
    descTEC
      ..removeListener(_textFieldListener)
      ..dispose();
    super.dispose();
  }

  void _textFieldListener() {
    setState(() => isTFFilledIn = titleTEC.text.isNotEmpty && descTEC.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: Text(
          widget.product != null
              ? LocaleKeys.edit_product.tr()
              : LocaleKeys.add_new_product.tr(),
          style: CustomTypography.body1Bold,
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.actionType == ActionType.productFormAction) {
            switch (state.status) {
              case Status.loading:
                context.loaderOverlay.show();

              case Status.success:
                context.loaderOverlay.hide();
                ProductDialog.show(
                  title: widget.product != null
                      ? LocaleKeys.product_updated.tr()
                      : LocaleKeys.product_added.tr(),
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
                child: Column(
                  children: [
                    _textfield(
                      label: LocaleKeys.title.tr(),
                      ctrl: titleTEC,
                    ),
                    _textfield(
                      label: LocaleKeys.description.tr(),
                      ctrl: descTEC,
                    ),
                    const Spacer(),
                    _saveBtn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textfield({
    required String label,
    required TextEditingController ctrl,
    ({InputState state, String text})? Function(String?)? helperText,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: PaddingUtils.paddingBottom),
      child: CommonTextField(
        controller: ctrl,
        labelText: label,
        showLabel: true,
        helperText: helperText,
        hintText: '',
      ),
    );
  }

  Widget _saveBtn() {
    return Padding(
      padding: EdgeInsets.only(top: PaddingUtils.paddingBottomScreen),
      child: CommonButton(
        title: widget.product != null ? LocaleKeys.update.tr() : LocaleKeys.add.tr(),
        columnCrossAxisAlignment: CrossAxisAlignment.center,
        isEnabled: isTFFilledIn,
        onTap: () {
          if (widget.product != null) {
            context.read<ProductBloc>().add(ProductEvent.updateProduct(
              id: widget.product?.id ?? 0, 
              title: titleTEC.text, 
              description: descTEC.text,
            ),);
          } else {
            context.read<ProductBloc>().add(ProductEvent.addProduct(
              title: titleTEC.text, 
              description: descTEC.text,
            ),);
          }
        },
      ),
    );
  }
}
