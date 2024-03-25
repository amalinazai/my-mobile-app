import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/utils/padding_utils.dart';
import 'package:my_mobile_app/common/utils/screen_utils.dart';
import 'package:my_mobile_app/common/widgets/buttons/common_button.dart';
import 'package:my_mobile_app/common/widgets/input/common_password_text_field.dart';
import 'package:my_mobile_app/common/widgets/input/common_text_field.dart';
import 'package:my_mobile_app/common/widgets/snackbars/common_snackbar.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/auth/bloc/auth_bloc.dart';
import 'package:my_mobile_app/feature/login/cubit/login_cubit.dart';
import 'package:my_mobile_app/feature/main/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Future<void> goTo(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<LoginPage>(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthBloc()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.loading:
              context.loaderOverlay.show();

            case AuthStatus.success:
              context.loaderOverlay.hide();
              MainPage.goTo(context);

            case AuthStatus.loginFailure:
              context.loaderOverlay.hide();
              CommonSnackbar.show(
                title: state.error ?? '',
                isSuccess: false,
              );

            case _:
          }
        },
        child: const _LoginPageView(),
      ),
    );
  }
}

class _LoginPageView extends StatelessWidget {
  const _LoginPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.alabaster,
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Column(
            children: [
              AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      height: ScreenUtils.screenHeight * 0.25,
                      margin: EdgeInsets.only(top: ScreenUtils.safePaddingTop + (ScreenUtils.screenHeight * 0.01)),
                    ),
                  ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtils.screenWidth * 0.08,
                  ),
                  decoration: const BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: _FieldsView(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FieldsView extends StatelessWidget {
  _FieldsView();

  final TextEditingController usernameTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: PaddingUtils.paddingBottomScreen,
            ),
            child: Center(
              child: Text(
                '${'welcome_back'.tr()}!',
                style: CustomTypography.h1,
              ),
            ),
          ),
          SizedBox(height: PaddingUtils.paddingBottomScreen),
          CommonTextField(
            controller: usernameTEC,
            hintText: 'username'.tr(),
            cursorColor: Palette.white,
            options: const TextFieldOptions(
              autocorrect: false,
            ),
          ),
          CommonPasswordTextField(
            margin: EdgeInsets.only(
              top: ScreenUtils.screenHeight * 0.05,
              bottom: ScreenUtils.screenHeight * 0.05,
            ),
            controller: passwordTEC,
            hintText: 'password'.tr(),
            cursorColor: Palette.white,
            options: const TextFieldOptions(
              autocorrect: false,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(height: ScreenUtils.screenHeight * 0.02,),
          CommonButton(
            title: 'login'.tr(),
            onTap: () => context.read<AuthBloc>().add(AuthEvent.onTapLogIn(context, usernameTEC.text, passwordTEC.text)),
            rightIconData: Icons.arrow_forward,
          ),
          SizedBox(height: PaddingUtils.paddingBottomScreen,),
        ],
      ),
    );
  }
}
