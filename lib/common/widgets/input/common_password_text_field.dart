import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/enums/input_state.dart';
import 'package:my_mobile_app/common/widgets/input/common_text_field.dart';
import 'package:my_mobile_app/constants/asset_paths.dart';

class CommonPasswordTextField extends StatefulWidget {
  const CommonPasswordTextField({
    required this.controller,
    required this.hintText,
    this.helperText,
    this.margin = EdgeInsets.zero,
    this.options = const TextFieldOptions(),
    this.cursorColor,
    this.labelText,
    super.key,
  });

  final TextEditingController controller;
  final ({InputState state, String text})? Function(String?)? helperText;
  final String hintText;
  final EdgeInsets margin;
  final TextFieldOptions options;
  final Color? cursorColor;
  final String? labelText;

  @override
  State<CommonPasswordTextField> createState() =>
      _CommonPasswordTextFieldState();
}

class _CommonPasswordTextFieldState extends State<CommonPasswordTextField> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return CommonTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      showLabel: widget.labelText != null,
      helperText: widget.helperText,
      margin: widget.margin,
      obscureText: isObscured,
      cursorColor: widget.cursorColor,
      options: widget.options,
      hasTrailingIcon: true,
      trailingIconData: TextFieldIconData(
        path: isObscured ? AssetPaths.eyeIcon : AssetPaths.eyeSlashIcon,
        onTap: () {
          isObscured = !isObscured;
          setState(() {});
        },
      ),
    );
  }
}
