import 'package:flutter/material.dart';
import 'package:newtronic_banking/presentation/widget/components.dart';
import 'package:newtronic_banking/styles/pallet.dart';
import 'package:shimmer/shimmer.dart';

Container shimmerHeader() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    height: 60,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        shimmerCircle(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            shimmerText(shimmerWidth: 80, shimmerHeight: 16),
            customSpaceVertical(8),
            shimmerText(shimmerWidth: 140, shimmerHeight: 16),
          ],
        ),
        shimmerCircle(),
      ],
    ),
  );
}

Container shimmerCard() {
  return Container(
    height: 240,
    margin: const EdgeInsets.only(top: 8),
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => customSpaceHorizontal(16),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: secondary10.withOpacity(.75),
        highlightColor: secondary10.withOpacity(.25),
        child: Container(
          width: 240,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: secondary10,
          ),
        ),
      ),
    ),
  );
}

Container shimmerClip() {
  return Container(
    height: 48,
    margin: const EdgeInsets.only(top: 8),
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (_, __) => customSpaceHorizontal(8),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: secondary10.withOpacity(.75),
        highlightColor: secondary10.withOpacity(.25),
        child: Container(
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: secondary10,
          ),
        ),
      ),
    ),
  );
}

Container shimmerTile() {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.vertical,
      separatorBuilder: (_, __) => customSpaceVertical(8),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: secondary10.withOpacity(.75),
        highlightColor: secondary10.withOpacity(.25),
        child: Container(
          width: 120,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: secondary10,
          ),
        ),
      ),
    ),
  );
}

Shimmer shimmerText({
  required double shimmerWidth,
  required double shimmerHeight,
}) {
  return Shimmer.fromColors(
    baseColor: secondary10.withOpacity(.75),
    highlightColor: secondary10.withOpacity(.25),
    child: Container(
      width: shimmerWidth,
      height: shimmerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: secondary10,
      ),
    ),
  );
}

Shimmer shimmerCircle() {
  return Shimmer.fromColors(
    baseColor: secondary10.withOpacity(.75),
    highlightColor: secondary10.withOpacity(.25),
    child: Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: secondary10,
      ),
    ),
  );
}
