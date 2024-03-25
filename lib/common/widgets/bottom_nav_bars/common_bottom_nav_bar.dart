// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_mobile_app/constants/custom_typography.dart';
import 'package:my_mobile_app/constants/palette.dart';

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final List<(String title, String iconPath)> items;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar.builder(
      height: 100,
      top: -30,
      curveSize: 90,
      backgroundColor: Palette.alabaster,
      count: items.length,
      onTap: onTap,
      itemBuilder: CustomDelegateBuilder(items: items),
      initialActiveIndex: currentIndex,
    );
  }
}

class CustomDelegateBuilder extends DelegateBuilder {
  final List<(String title, String iconPath)> items;

  CustomDelegateBuilder({required this.items});

  @override
  Widget build(BuildContext context, int index, bool active) {
    final item = items[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (active)
          Expanded(
            child: Container(
              width: 65,
              height: 66,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.olivine,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ImageIcon(
                AssetImage(item.$2),
                color: Palette.black,
                size: 40,
              ),
            ),
          ),
        if (!active)
          Expanded(
            child: ImageIcon(
              AssetImage(item.$2),
              color: Palette.black,
              size: 40,
            ),
          ),
        Text(
          item.$1,
          style: CustomTypography.body3Bold.copyWith(color: Palette.black),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
