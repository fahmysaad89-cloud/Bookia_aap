import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_snack_bar.dart';
import 'package:bookiaa/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:bookiaa/features/favourite/presentation/ui/widgets/favourite_empty_state.dart';
import 'package:bookiaa/features/favourite/presentation/ui/widgets/favourite_item.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            18.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Favorites',
                  style: AppTextStyles.mainFont.copyWith(fontSize: 24),
                ),
                BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    final cubit = context.read<FavouriteCubit>();
                    final count = cubit.favourites.length;
                    if (count == 0) return const SizedBox.shrink();

                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '$count ${count == 1 ? "book" : "books"}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            16.verticalSpace,
            Expanded(
              child: BlocConsumer<FavouriteCubit, FavouriteState>(
                listener: (context, state) {
                  if (state is RemoveFromFavouriteSuccess) {
                    AppSnackBar.showSuccess(
                      context,
                      title: 'Favorites',
                      message: state.message,
                    );
                  } else if (state is RemoveFromFavouriteError) {
                    AppSnackBar.showError(
                      context,
                      title: 'Error',
                      message: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  // Loading
                  if (state is GetFavouriteLoading) {
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
                          return FavouriteItem(
                            product: Products(
                              name: 'Loading...',
                              price: '205',
                              image:
                                  'https://krinitsa.by/wp-content/themes/krinitsa/assets/i/no.png',
                            ),
                          );
                        },
                      ),
                    );
                  }

                  // Error
                  if (state is GetFavouriteError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.redAccent,
                              size: 48,
                            ),
                            12.verticalSpace,
                            Text(
                              state.message ?? 'Please check your network.',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.darkColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            16.verticalSpace,
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<FavouriteCubit>()
                                    .getFavourites();
                              },
                              child: const Text(
                                'Try Again',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final cubit = context.read<FavouriteCubit>();
                  final products = (state is GetFavouriteSuccess)
                      ? state.products
                      : cubit.favourites;

                  // Empty State
                  if (products.isEmpty) {
                    return RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () =>
                          context.read<FavouriteCubit>().getFavourites(),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 120.h),
                          FavouriteEmptyState(
                            onExplore: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRoutes.bottomnNavScreen,
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  // Success State
                  return RefreshIndicator(
                    color: AppColors.primaryColor,
                    onRefresh: () =>
                        context.read<FavouriteCubit>().getFavourites(),
                    child: GridView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .53,
                        mainAxisSpacing: 14.h,
                        crossAxisSpacing: 18.w,
                      ),
                      itemBuilder: (context, index) {
                        return FavouriteItem(product: products[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
