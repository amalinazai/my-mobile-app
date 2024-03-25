import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/widgets/loaders/common_loader.dart';
import 'package:my_mobile_app/common/widgets/utils/double_tap_exit.dart';
import 'package:my_mobile_app/feature/auth/auth.dart';
import 'package:my_mobile_app/feature/login/login.dart';
import 'package:my_mobile_app/feature/main/pages/main_page.dart';
import 'package:my_mobile_app/feature/start/cubit/start_cubit.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static Future<void> goTo(BuildContext context) async {
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute<StartPage>(
        builder: (context) => const StartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapExit(
      child: BlocProvider<StartCubit>.value(
        value: context.read<StartCubit>()..initialize(),
        child: BlocListener<StartCubit, StartState>(
          listenWhen: (previous, current) => previous != current,
          listener: (context, state) {
            state.whenOrNull(
              loading: context.loaderOverlay.show,
              loaded: (isAuthenticated) {

                context.read<AuthBloc>().add(AuthEvent.setAuthenticated(isAuthenticated));

                context.loaderOverlay.hide();

                if (isAuthenticated) {
                  MainPage.goTo(context);
                } else {
                  LoginPage.goTo(context);
                }
              },
            );
          },
          child: const _StartPageView(),
        ),
      ),
    );
  }
}

class _StartPageView extends StatelessWidget {
  const _StartPageView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CommonLoader(),
      ),
    );
  }
}
