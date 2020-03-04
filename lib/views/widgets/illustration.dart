import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/helpers/colors.dart';

class Illustration extends StatelessWidget {
  final String image;

  /// image width
  final double width;

  /// image height
  final double height;

  const Illustration({
    Key key,
    @required this.image,
    this.width = 300.0,
    this.height = 420.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      child: SvgPicture.asset(
        image,
        placeholderBuilder: (context) => SpinKitThreeBounce(
          color: AppColors.primary,
          size: 30,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
