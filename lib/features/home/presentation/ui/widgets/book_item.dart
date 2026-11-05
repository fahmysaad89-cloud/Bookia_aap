import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_snack_bar.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  final Products? product;
  const BookItem({super.key, this.product});

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
            BlocConsumer<HomeCubit, HomeState>(
              listenWhen: (previous, current) {
                final id = product?.id;
                if (id == null) return false;
                return (current is AddToCardSuccsess &&
                        current.productId == id) ||
                    (current is AddToCardError && current.productId == id);
              },
              listener: (context, state) {
                if (state is AddToCardSuccsess) {
                  AppSnackBar.showSuccess(
                    context,
                    title: 'Added to Cart!',
                    message: '${product?.name ?? "Book"} added to your cart.',
                  );
                } else if (state is AddToCardError) {
                  AppSnackBar.showError(
                    context,
                    title: 'Could Not Add',
                    message: state.message ?? 'Failed to add product to cart.',
                  );
                }
              },
              buildWhen: (previous, current) {
                final id = product?.id;
                if (id == null) return false;
                final wasLoading =
                    previous is AddToCardLoading && previous.productId == id;
                final isLoading =
                    current is AddToCardLoading && current.productId == id;
                return wasLoading != isLoading;
              },
              builder: (context, state) {
                final isLoading =
                    state is AddToCardLoading && state.productId == product?.id;

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
                    if (isLoading)
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
                            context.read<HomeCubit>().AddToCart(id);
                          }
                        },
                        borderRadius: BorderRadius.circular(20.r),
                        child: Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.primaryColor,
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
