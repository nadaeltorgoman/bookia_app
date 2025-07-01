import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigation.dart';
import 'package:bookia/core/routers/app_routers.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_widget.dart';
import 'package:bookia/features/home/presentation/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            AppAssets.logo,
            width: 120, // Use a finite width
            fit: BoxFit.cover,
          ),
          centerTitle: false,
          actions: [
            IconButton(
              icon: SvgPicture.asset(AppAssets.searchIcon, width: 24),
              onPressed: () {
                // Handle search
                context.navigateTo(
                  AppRouters.login, // Replace with your search screen route
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Gap(10),
                  CarouselWidget(sliders: cubit.sliders),
                  BestSellerWidget(bestSellers: cubit.bestSellers),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
