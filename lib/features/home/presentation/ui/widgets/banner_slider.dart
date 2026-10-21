import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final List<String> _banners = [
    'assets/images/slider_image.png',
    'assets/images/slider_image.png',
    'assets/images/slider_image.png',
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          options: CarouselOptions(
            height: 130.h,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 400),
            onPageChanged: (index, _) => setState(() => _current = index),
          ),
          itemBuilder: (context, index, _) => ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              _banners[index],
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        AnimatedSmoothIndicator(
          activeIndex: _current,
          count: _banners.length,
          effect: ExpandingDotsEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            expansionFactor: 5,
            spacing: 6.w,
            activeDotColor: AppColors.primaryColor,
            dotColor: const Color(0xFFD9D9D9),
          ),
        ),
      ],
    );
  }
}
