import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_mobile_app/common/services/locator_service.dart';
import 'package:my_mobile_app/common/services/navigator_service.dart';
import 'package:my_mobile_app/common/widgets/loaders/common_full_screen_loader.dart';
import 'package:my_mobile_app/feature/auth/bloc/auth_bloc.dart';
import 'package:my_mobile_app/feature/products/bloc/product_bloc.dart';
import 'package:my_mobile_app/feature/start/cubit/start_cubit.dart';
import 'package:my_mobile_app/feature/start/pages/start_page.dart';
import 'package:my_mobile_app/flavors.dart';
import 'package:my_mobile_app/settings/localization/cubit/localization_cubit.dart';
import 'package:my_mobile_app/settings/localization/localization_helper.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => LocalizationCubit()),
        BlocProvider(create: (ctx) => StartCubit()),
        BlocProvider(create: (ctx) => AuthBloc()),
        BlocProvider(create: (ctx) => ProductBloc()),
      ],
      child: const _AppEntry(),
    );
  }
}

class _AppEntry extends StatelessWidget {
  const _AppEntry();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (ctx) {
        final localizationState = context.watch<LocalizationCubit>().state;

        final currentLocale =
            LocalizationHelper.currentLocale(localizationState);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const CommonFullScreenLoader(),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MaterialApp(
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(textScaler: TextScaler.noScaling),
                    child: child!,
                  );
                },
                title: F.title,
                navigatorKey: locator.get<NavigatorService>().mainKey,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: currentLocale,
                debugShowCheckedModeBanner: false,
                home: const StartPage(),
              ),
            ),
          ),
        );
      },
    );
  }
}
