import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/settings/localization/locale_keys.g.dart';

class CommonLoader extends StatelessWidget {

  const CommonLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loaderView(),
          loaderText(),
        ],
      ),
    );
  }

  Widget loaderView() {
    return const SizedBox(
      width: 52,
      height: 52,
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.white,
      ),
    );
  }

  Widget loaderText() {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        LocaleKeys.loader_title,
        style: const TextStyle().copyWith(
          color: Colors.white,
        ),
      ).tr(),
    );
  }
}
