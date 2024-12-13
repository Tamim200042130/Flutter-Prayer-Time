import 'package:flutter/material.dart';
import '../../constants/size_constants.dart';
import '../constants/color_constants.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.width,
    this.height,
    this.marginH = SizeConstants.normal,
    this.marginV = SizeConstants.small,
    this.padding = SizeConstants.normal,
    this.radius = SizeConstants.normal,
    this.onTap,
    required this.child,
    this.colors = Colors.white,
  });

  final Widget child;
  final double? width;
  final double? height;
  final double marginH;
  final double marginV;
  final double padding;
  final double radius;
  final Function()? onTap;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: ColorConstants.primary,
      child: Container(
        width: width ?? double.maxFinite,
        height: height,
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: ColorConstants.neutral20,
            width: 1,
          ),
          boxShadow: ColorConstants.shadow08250,
        ),
        child: child,
      ),
    );
  }
}
