import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/features/profile/presentation/widgets/custom_row_widget.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.pop();
            context.navigateToNamedReplacement(AppRouters.login);
          } else if (state is ProfileError) {
            context.pop();
            showErrorSnackbar(context, state.message);
          } else if (state is ProfileLoading) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: SvgPicture.asset(AppAssets.logoutIcon),
                  onPressed: () {
                    context.read<ProfileCubit>().logout();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileHeader(),
                      const SizedBox(height: 20),
                      CustomRowWidget(title: 'My Orders', onPressed: () {}),
                      const SizedBox(height: 10),
                      CustomRowWidget(title: 'Edit Profile', onPressed: () {}),
                      const SizedBox(height: 10),
                      CustomRowWidget(title: 'Reset Password', onPressed: () {}),
                      const SizedBox(height: 10),
                      CustomRowWidget(title: 'FAQ', onPressed: () {}),
                      const SizedBox(height: 10),
                      CustomRowWidget(title: 'Contact Us', onPressed: () {}),
                      const SizedBox(height: 10),
                      CustomRowWidget(title: 'Privacy & Terms', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
