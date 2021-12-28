import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;

  const SocialIcon({Key? key, required this.iconSrc, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            shape: BoxShape.circle),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
