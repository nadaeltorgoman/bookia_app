import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/model/response/slider_response/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key, required this.sliders});
  final List<SliderModel> sliders;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          widget.sliders.isEmpty
              ? emptyUI()
              : CarouselSlider.builder(
                itemCount: widget.sliders.length,
                itemBuilder: (context, index, realIndex) {
                  return widget.sliders.isEmpty
                      ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.borderColor,
                        ),
                      )
                      : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              widget.sliders[index].image ??
                              AppAssets.backgroundImage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget:
                              (context, url, error) => const Icon(
                                Icons.error,
                                color: AppColors.errorColor,
                                size: 30,
                              ),
                        ),
                      );
                },
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    // Handle page change
                    setState(() {
                      activeIndex = index;
                    });
                  },
                ),
              ),
          Gap(15),
          if (widget.sliders.isNotEmpty)
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.sliders.length,
              effect: ExpandingDotsEffect(
                dotColor: AppColors.borderColor,
                activeDotColor: AppColors.primaryColor,
                dotWidth: 8.0,
                dotHeight: 8.0,
                spacing: 4.0,
                expansionFactor: 5.0,
              ),
              onDotClicked: (index) {},
            ),
        ],
      ),
    );
  }

  Widget emptyUI() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      child: Shimmer.fromColors(
        baseColor: AppColors.borderColor,
        highlightColor: AppColors.primaryColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.borderColor,
          ),
        ),
      ),
    );
  }
}
