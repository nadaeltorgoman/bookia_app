import 'package:flutter/material.dart';
import 'package:bookia/features/auth/presentation/widgets/app_leading_button.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBarWidget({super.key, this.action});
  final Widget? action;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: AppLeadingButton(),
      actions: [action ?? Container()],
    );
  }
}
