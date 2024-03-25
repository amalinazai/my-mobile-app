import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// The [CommonShimmer] fits the size of its parent by default,
/// so wrap it with a sized container or box to set its size.
///
/// Important! The shimmer effect will only be displayed if the
/// container it is wrapping has a non-transparent color.
class CommonShimmer extends StatelessWidget {
  const CommonShimmer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: child,
    );
  }
}
