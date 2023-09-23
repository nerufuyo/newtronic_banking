import 'package:flutter/material.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:shimmer/shimmer.dart';

Shimmer shimmerHeader() {
  return Shimmer.fromColors(
    baseColor: secondary10,
    highlightColor: secondary10.withOpacity(.2),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondary10.withOpacity(.5),
      ),
    ),
  );
}
