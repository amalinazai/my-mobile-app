import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/buttons/common_button.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/auth/bloc/auth_bloc.dart';
import 'package:my_mobile_app/feature/user/model/user_model.dart';
import 'package:my_mobile_app/feature/user/user_utils.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static Future<void> goTo(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<ProfilePage>(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  @override
  State<ProfilePage> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  User? user;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _playAnimation();
    _getUser();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _animationController
      ..reset()
      ..forward();
  }

  Future<void> _getUser() async {
    user = await UserUtils.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.pearl,
      body: Stack(
        children: [
          _bgWithMsg(),
          _mainContainer(),
        ],
      ),
    );
  }

  Widget _bgWithMsg() {
    return Column(
      children: [
        Container(
          height: 0.12 * ScreenUtils.screenHeight,
          margin: EdgeInsets.only(
            top: ScreenUtils.safePaddingTop + 0.01 * ScreenUtils.screenHeight,
          ),
          child: Stack(
            children: [
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.08 * ScreenUtils.screenWidth,
                    vertical: 0.02 * ScreenUtils.screenHeight,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Hi, ${LocaleKeys.welcome_back.tr()} 👋',
                      style: CustomTypography.h4
                          .copyWith(color: Palette.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  Widget _mainContainer() {
    return Column(
      children: [
        Container(
          height: 0.10 * ScreenUtils.screenHeight,
          margin: EdgeInsets.only(
            top: ScreenUtils.safePaddingTop + 0.01 * ScreenUtils.screenHeight,
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 0.04 * ScreenUtils.screenWidth,
              right: 0.04 * ScreenUtils.screenWidth,
              top: 0.03 * ScreenUtils.screenHeight,
            ),
            decoration: const BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: PaddingUtils.paddingTop),
                CircleAvatar(
                  backgroundColor: Palette.alabaster.withOpacity(0.5),
                  radius: ScreenUtils.screenWidth * 0.2,
                  backgroundImage: user?.image != null ? NetworkImage(
                    user?.image ?? '',
                  ) : null,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: PaddingUtils.paddingBottom),
                  child: Text('${user?.firstName} ${user?.lastName}', style: CustomTypography.body1Bold),
                ),
                Text('@${user?.username}', style: CustomTypography.body1Bold),
                Padding(
                  padding: EdgeInsets.only(top: PaddingUtils.paddingTopScreen),
                  child: CommonButton(
                    title: LocaleKeys.logout.tr(), 
                    onTap: () => context.read<AuthBloc>().add(const AuthEvent.onTapLogOut()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
