import 'package:flutter/material.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';

enum CommonButtonStyle { primary, secondary, ghost }

class CommonButton extends StatelessWidget {
  CommonButton({
    required this.title,
    required this.onTap,
    this.style = CommonButtonStyle.primary,
    this.titleColor,
    this.isEnabled = true,
    this.width = double.infinity,
    BorderRadius? borderRadius,
    this.textStyle,
    this.innerPadding,
    this.customColor,
    this.customLeftIcon,
    this.customRightIcon,
    this.leftIconData,
    this.leftIconSize,
    this.rightIconData,
    this.rightIconSize,
    this.secondLineWidget,
    this.columnCrossAxisAlignment,
    this.maxLines = 1,
    this.useFittedBox = false,
    super.key,
  }) : borderRadius = borderRadius ?? BorderRadius.circular(30);

  final String title;
  final Color? titleColor;
  final VoidCallback? onTap;
  final CommonButtonStyle style;
  final bool isEnabled;
  final double width;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsets? innerPadding;
  final Color? customColor;
  // Left or right icon
  final Widget? customLeftIcon;
  final Widget? customRightIcon;
  final IconData? leftIconData;
  final double? leftIconSize;
  final IconData? rightIconData;
  final double? rightIconSize;
  // Second line widget
  final Widget? secondLineWidget;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  final int maxLines;
  final bool useFittedBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: colors(context).background,
        borderRadius: borderRadius,
        border: Border.all(
          width: 2,
          color: colors(context).border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: style == CommonButtonStyle.primary
              ? Palette.black.withOpacity(0.1)
              : colors(context).mainColor.withOpacity(0.5),
          onTap: isEnabled ? onTap : (){},
          borderRadius: borderRadius,
          child: Padding(
            padding: innerPadding ??
                EdgeInsets.symmetric(
                  horizontal: 0.06 * ScreenUtils.screenWidth,
                  vertical: 0.02 * ScreenUtils.screenHeight,
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (customLeftIcon != null) customLeftIcon!,
                if (leftIconData != null)
                  Icon(
                    leftIconData,
                    color: colors(context).foreground,
                    size: leftIconSize ?? 0.08 * ScreenUtils.screenWidth,
                  ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        columnCrossAxisAlignment ?? CrossAxisAlignment.start,
                    children: [
                      if(useFittedBox)...[
                        FittedBox(child: titleWidget(context)),
                      ]
                      else...[
                        titleWidget(context),
                      ],
                      secondLineWidget ?? const SizedBox(),
                    ],
                  ),
                ),
                if (customRightIcon != null) customRightIcon!,
                if (rightIconData != null)
                  Icon(
                    rightIconData,
                    color: colors(context).foreground,
                    size: rightIconSize ?? 0.08 * ScreenUtils.screenWidth,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWidget(BuildContext context){
    return Text(
      title,
      style: (textStyle ?? CustomTypography.h4).copyWith(
        color: titleColor ?? colors(context).foreground,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  ButtonColors colors(BuildContext context) {
    Color mainColor;
    Color backgroundColor;
    Color foregroundColor;
    Color borderColor;

    switch (style) {
      case CommonButtonStyle.primary:
        mainColor = backgroundColor = !isEnabled 
          ? Palette.black.withOpacity(0.3) 
          : customColor ?? Palette.calPolyGreen;
        foregroundColor = Colors.white;
        borderColor = Colors.transparent;
      case CommonButtonStyle.secondary:
        mainColor = borderColor = !isEnabled 
          ? Palette.black.withOpacity(0.3) 
          : customColor ?? Palette.calPolyGreen;
        backgroundColor = Palette.white;
        foregroundColor = !isEnabled 
          ? Palette.black.withOpacity(0.3) 
          : customColor ?? Palette.calPolyGreen;
      case CommonButtonStyle.ghost:
        mainColor = !isEnabled 
          ? Palette.black.withOpacity(0.3) 
          : customColor ?? Palette.calPolyGreen;
        backgroundColor = Colors.transparent;
        foregroundColor = !isEnabled 
          ? Palette.black.withOpacity(0.3) 
          : customColor ?? Palette.calPolyGreen;
        borderColor = Colors.transparent;
    }

    return ButtonColors(
      mainColor: mainColor,
      background: backgroundColor,
      foreground: foregroundColor,
      border: borderColor,
    );
  }
}

class ButtonColors {
  const ButtonColors({
    required this.mainColor,
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color mainColor;
  final Color background;
  final Color foreground;
  final Color border;
}
