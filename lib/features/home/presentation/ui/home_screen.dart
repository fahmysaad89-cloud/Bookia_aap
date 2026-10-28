import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookiaa/features/home/presentation/ui/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/banner_slider.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            children: [
              HomeHeader(
                onSearchTap: () {
                  Navigator.pushNamed(context, AppRoutes.searchScreen);
                },
              ),

              25.verticalSpace,

              const BannerSlider(),

              52.verticalSpace,

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Text(
                    'Best Seller',
                    style: AppTextStyles.mainFont.copyWith(fontSize: 24),
                  ),
                ),
              ),

              15.verticalSpace,

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    // Loading
                    if (state is GetBestSellerloding) {
                      return Skeletonizer(
                        enabled: true,
                        child: GridView.builder(
                          itemCount: 8,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .53,
                                mainAxisSpacing: 14.h,
                                crossAxisSpacing: 18.w,
                              ),
                          itemBuilder: (context, index) {
                            return BookItem(
                              product: Products(
                                name: 'Loading...',
                                price: '205',
                                image:
                                    "https://krinitsa.by/wp-content/themes/krinitsa/assets/i/no.png",
                              ),
                            );
                          },
                        ),
                      );
                    }

                    // Success
                    if (state is GetBestSellerSuccess) {
                      final products = state.products ?? [];

                      if (products.isEmpty) {
                        return const Center(child: Text('No books available'));
                      }

                      return GridView.builder(
                        itemCount: products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .53,
                          mainAxisSpacing: 14.h,
                          crossAxisSpacing: 18.w,
                        ),
                        itemBuilder: (context, index) {
                          return BookItem(product: products[index]);
                        },
                      );
                    }

                    // Error
                    if (state is GetBestSellerError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 45,
                            ),
                            12.verticalSpace,
                            const Text(
                              'Please check your network.',
                              textAlign: TextAlign.center,
                            ),
                            12.verticalSpace,
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeCubit>().getsellerbooks();
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }

                    // Initial state
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
