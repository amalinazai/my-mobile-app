
import 'package:my_mobile_app/common/utils/screen_utils.dart';

class PaddingUtils {
  static double paddingLeftRight = ScreenUtils.screenWidth * 0.05;

  static double paddingTopBottom = ScreenUtils.screenHeight * 0.02;
  static double paddingTop = ScreenUtils.screenHeight * 0.02;
  static double paddingBottom = ScreenUtils.screenHeight * 0.02;

  static double paddingTopScreen = ScreenUtils.safePaddingTop == 0 
    ? ScreenUtils.screenHeight * 0.03
    : ScreenUtils.safePaddingTop + ScreenUtils.screenHeight * 0.01;
    
  static double paddingBottomScreen = ScreenUtils.safePaddingBottom == 0 
    ? ScreenUtils.screenHeight * 0.02
    : ScreenUtils.safePaddingBottom + ScreenUtils.screenHeight * 0.01;

  static double paddingDialogLeftRight = ScreenUtils.screenWidth * 0.05;
  static double paddingContentDialog = ScreenUtils.screenWidth * 0.06;

  static double bottomServiceScroll = ScreenUtils.screenHeight * 0.2; 

  static double paddingVerticalService = 0.02 * ScreenUtils.screenHeight;
  static double paddingHorizontalService = 0.065 * ScreenUtils.screenWidth;

  static double paddingVertical = 0.04 * ScreenUtils.screenHeight;
  static double paddingHorizontal = 0.07 * ScreenUtils.screenWidth;
}
