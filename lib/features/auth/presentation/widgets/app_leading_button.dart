import 'package:bookia/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AppLeadingButton extends StatelessWidget {
  const AppLeadingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () => context.pop(),
        child: SvgPicture.asset(AppAssets.backArrowIcon, width: 40, height: 40),
      ),
    );
  }
}
