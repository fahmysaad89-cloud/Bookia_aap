import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteItem extends StatelessWidget {
  final Products? product;

  const FavouriteItem({
    super.key,
    this.product,
  });

  String get _formattedPrice {
    final price = product?.price;
    if (price == null || price.isEmpty) return '';
    return price.contains('\$') ? price : '\$$price';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product?.id != null) {
          Navigator.pushNamed(
            context,
            AppRoutes.bookdetailsscreen,
            arguments: product?.id,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: (product?.image != null && product!.image!.isNotEmpty)
                    ? Image.network(
                        product!.image!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          color: AppColors.borderColor,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        color: AppColors.borderColor,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ),
              ),
            ),
            10.verticalSpace,
            Text(
              product?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.darkColor,
              ),
            ),
            6.verticalSpace,
            BlocBuilder<FavouriteCubit, FavouriteState>(
              buildWhen: (previous, current) {
                final id = product?.id;
                if (id == null) return false;
                final wasLoading = previous is RemoveFromFavouriteLoading &&
                    previous.productId == id;
                final isLoading = current is RemoveFromFavouriteLoading &&
                    current.productId == id;
                return wasLoading != isLoading;
              },
              builder: (context, state) {
                final isRemoving = state is RemoveFromFavouriteLoading &&
                    state.productId == product?.id;

                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        _formattedPrice,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isRemoving)
                      SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: Center(
                          child: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      )
                    else
                      InkWell(
                        onTap: () {
                          final id = product?.id;
                          if (id != null) {
                            context
                                .read<FavouriteCubit>()
                                .removeFromFavourite(id);
                          }
                        },
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            Icons.bookmark_remove_rounded,
                            color: Colors.redAccent,
                            size: 22.sp,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

