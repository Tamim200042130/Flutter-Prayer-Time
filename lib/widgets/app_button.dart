import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../constants/size_constants.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title,
    this.height = 48,
    this.width,
    this.radius = 12,
    this.marginV = SizeConstants.tiny,
    this.marginH = SizeConstants.tiny,
    this.color = ColorConstants.primary,
    this.textColor = Colors.white,
    this.isDisabled = false,
    this.icon, this.onTap,
  });

  final String? title;
  final double height;
  final double? width;
  final double radius;
  final double marginH;
  final double marginV;
  final Color color;
  final Color textColor;
  final Function()? onTap;
  final bool isDisabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginV, horizontal: marginH),
      height: height,
      width: width ?? size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: isDisabled ? Theme.of(context).disabledColor : color,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.all(SizeConstants.small),
                child: Icon(icon, color: textColor,),
              ),
            title!= null ?Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeConstants.small),
              child: Text(
                title??"",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ): Container(),
          ],
        ),
      ),
    );
  }
}
