import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/widgets/bottom_nav_bars/common_bottom_nav_bar.dart';
import 'package:my_mobile_app/constants/asset_paths.dart';
import 'package:my_mobile_app/constants/palette.dart';
import 'package:my_mobile_app/feature/auth/bloc/auth_bloc.dart';
import 'package:my_mobile_app/feature/home/pages/home_page.dart';
import 'package:my_mobile_app/feature/main/cubit/main_cubit.dart';
import 'package:my_mobile_app/feature/profile/pages/profile_page.dart';
import 'package:my_mobile_app/feature/start/pages/start_page.dart';

final List<(Widget page, String title, String iconPath)> _pages = [
  (const HomePage(), 'Home', AssetPaths.home),
  (Container(color: Palette.calPolyGreen), 'Booking', AssetPaths.bookings),
  (Container(color: Palette.mintCream), 'Notification', AssetPaths.notification),
  (const ProfilePage(), 'Profile', AssetPaths.profile),
];

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static Future<void> goTo(BuildContext context) async {
    await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<MainPage>(
        builder: (context) => const MainPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => MainCubit()),
          BlocProvider(create: (ctx) => AuthBloc()..add(const AuthEvent.onUserInitialized())),
        ],
              child: const _MainPageView(),
    );
  }
}

class _MainPageView extends StatefulWidget {
  const _MainPageView();

  @override
  State<_MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<_MainPageView> {
//============================================================
// ** Properties **
//============================================================

  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

//============================================================
// ** Flutter Build Cycle **
//============================================================

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MainCubit, MainState>(
          listenWhen: (previous, current) =>
              previous.tabIndex != current.tabIndex,
          listener: (context, state) =>
              _pageController.jumpToPage(state.tabIndex),
        ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous != current,
          listener: (ctx, state) {
            if (state.status == AuthStatus.loading) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state.status == AuthStatus.loggedOut) {
              // Do something if needed
              StartPage.goTo(context);
            }
          },
        ),
      ],
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
            _pages.length,
            (index) => _pages[index].$1,
            growable: false,
          ),
        ),
        bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
          builder: (ctx, state) {
            return CommonBottomNavBar(
              currentIndex: state.tabIndex,
              onTap: (index) => ctx.read<MainCubit>().updateTab(index),
              items: List.generate(
                _pages.length,
                (index) => (_pages[index].$2, _pages[index].$3),
                growable: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
