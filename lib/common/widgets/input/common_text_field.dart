import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_mobile_app/common/enums/input_state.dart';

import 'package:my_mobile_app/common/widgets/input/common_helper_text.dart';
import 'package:my_mobile_app/constants/asset_paths.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    this.controller,
    this.hintText,
    this.showLabel = false,
    this.labelText,
    this.helperText,
    this.margin = EdgeInsets.zero,
    this.obscureText = false,
    this.options = const TextFieldOptions(),
    this.backgroundColor,
    this.cursorColor,
    this.hasLeadingIcon = false,
    this.hasTrailingIcon = false,
    this.trailingIconData,
    this.radius,
    this.hintStyle,
    this.onChanged,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController? controller;
  final ({InputState state, String text})? Function(String?)? helperText;
  final String? hintText;
  final bool showLabel;
  final String? labelText;
  final EdgeInsets margin;
  final bool obscureText;
  final TextFieldOptions options;
  final Color? backgroundColor;
  final Color? cursorColor;
  final bool hasLeadingIcon;
  final bool hasTrailingIcon;
  final TextFieldIconData? trailingIconData;
  final double? radius;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode focusNode = FocusNode();
  InputState currentState = InputState.none;
  String currentHelperText = '';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller ?? TextEditingController(),
        builder: (_, value, __) {
          _updateHelperText(value);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TextField(
                focusNode: focusNode,
                widget: widget,
                backgroundColor: widget.backgroundColor,
                radius: widget.radius,
                textFieldColor: _getTextFieldColor(),
                hintTextColor: _getHintTextColor(),
                borderWidth: _getBorderWidth(),
                hintStyle: widget.hintStyle,
                onChanged: widget.onChanged,
              ),
              const SizedBox(height: 2),
              if (currentHelperText.isNotEmpty)
                CommonHelperText(
                  text: currentHelperText,
                  inputState: currentState,
                ),
            ],
          );
        },
      ),
    );
  }

  void _handleFocusChange() {
    setState(() {});
  }

  void _updateHelperText(TextEditingValue value) {
    final helperTextInfo = widget.helperText?.call(value.text);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (helperTextInfo != null) {
          setState(() {
            currentState = helperTextInfo.state;
            currentHelperText = helperTextInfo.text;
          });
        } else {
          setState(() {
            currentState = InputState.none;
            currentHelperText = '';
          });
        }
      }
    });
  }

  Color _getTextFieldColor() {
    if (!widget.options.enabled) {
      return Colors.transparent;
    } else if (focusNode.hasFocus) {
      switch (currentState) {
        case InputState.none:
          return widget.options.customColor ?? Palette.calPolyGreen;
        case InputState.error:
          return Palette.error;
        case InputState.success:
          return Palette.success;
      }
    } else {
      return Palette.black.withOpacity(0.5);
    }
  }

  Color _getHintTextColor() {
    switch (currentState) {
      case InputState.none:
        return Palette.black.withOpacity(0.5);
      case InputState.error:
        return Palette.error;
      case InputState.success:
        return Palette.success;
    }
  }

  double _getBorderWidth() =>
      focusNode.hasFocus && currentState == InputState.none ? 2 : 1;
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.focusNode,
    required this.widget,
    required this.hintTextColor,
    required this.textFieldColor,
    this.backgroundColor,
    this.radius,
    this.borderWidth = 1,
    this.hintStyle,
    this.onChanged,
  });

  final FocusNode focusNode;
  final CommonTextField widget;
  final Color textFieldColor;
  final Color hintTextColor;
  final Color? backgroundColor;
  final double? radius;
  final double? borderWidth;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 48,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: _showLabelCheck() ? 10 : 15,
        bottom: _showLabelCheck() ? 15 : 15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth ?? 1,
          color: textFieldColor,
        ),
        borderRadius: BorderRadius.circular(radius ?? 20),
        color: widget.options.enabled ? Colors.transparent : Palette.black.withOpacity(0.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_showLabelCheck())
            Text(
              widget.labelText ?? 'default_search_hint_text'.tr(),
              style: CustomTypography.body4.copyWith(
                color: hintTextColor,
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.hasLeadingIcon)
                _TextFieldIcon(
                  isLeading: true,
                  iconColor: hintTextColor,
                ),
              Expanded(
                child: TextField(
                  autocorrect: widget.options.autocorrect,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  cursorColor: widget.cursorColor,
                  decoration: InputDecoration.collapsed(
                    hintText: !focusNode.hasFocus
                        ? widget.hintText ?? 'default_search_hint_text'.tr()
                        : '',
                    hintStyle: hintStyle ?? CustomTypography.body2.copyWith(
                      color: Palette.black.withOpacity(0.6),
                    ),
                  ),
                  enabled: widget.options.enabled,
                  obscureText: widget.obscureText,
                  focusNode: focusNode,
                  keyboardType: widget.options.keyboardType,
                  maxLines: widget.options.isMultiline
                      ? widget.options.multilineNo
                      : 1,
                  minLines: widget.options.isMultiline
                      ? widget.options.multilineNo
                      : 1,
                  style: CustomTypography.body2,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: widget.options.textInputAction,
                  inputFormatters: widget.inputFormatters,
                ),
              ),
              if (widget.hasTrailingIcon)
                _TextFieldIcon(
                  isLeading: false,
                  iconColor: hintTextColor,
                  iconData: widget.trailingIconData,
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool _showLabelCheck() {
    return widget.showLabel;
  }
}

class _TextFieldIcon extends StatelessWidget {
  const _TextFieldIcon({
    required this.isLeading,
    required this.iconColor,
    this.iconData,
  });

  final bool isLeading;
  final Color iconColor;
  final TextFieldIconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: iconData?.onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: isLeading ? 0 : 15,
          right: isLeading ? 15 : 0,
        ),
        child: Image.asset(
          iconData?.path ?? AssetPaths.placeholderIcon,
          width: 30,
          gaplessPlayback: true,
          color: iconColor,
        ),
      ),
    );
  }
}

/// Used to determine the behaviour of the textfield.
class TextFieldOptions {
  const TextFieldOptions({
    this.autocorrect = true,
    this.enabled = true,
    this.isMultiline = false,
    this.multilineNo = 5,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.customColor,
  });

  final bool autocorrect;
  final bool enabled;

  /// Determines whether the TF should be a large one or a single-line one.
  final bool isMultiline;
  final int multilineNo;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color? customColor;
}

class TextFieldIconData {
  const TextFieldIconData({
    required this.path,
    this.onTap,
  });
  final String path;
  final VoidCallback? onTap;
}
