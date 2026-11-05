import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_botton.dart';
import 'package:bookiaa/core/widgets/app_snack_bar.dart';
import 'package:bookiaa/features/cart/data/models/cart_response.dart';
import 'package:bookiaa/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookiaa/features/cart/presentation/ui/widgets/cart_bottom_bar.dart';
import 'package:bookiaa/features/cart/presentation/ui/widgets/cart_empty_state.dart';
import 'package:bookiaa/features/cart/presentation/ui/widgets/cart_item_card.dart';
import 'package:bookiaa/features/cart/presentation/ui/widgets/cart_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void _confirmRemove(BuildContext context, CartItem item) {
    if (item.itemId == null) return;
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Remove from cart?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkColor,
          ),
        ),
        content: Text(
          'Are you sure you want to remove "${item.itemProductName ?? "this book"}" from your cart?',
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.grayColor,
            height: 1.3,
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.darkColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<CartCubit>().removeItem(item.itemId!);
            },
            child: Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutSheet(BuildContext context, CartData cartData) {
    final itemsCount = cartData.cartItems.fold<int>(
      0,
      (sum, it) => sum + it.itemQuantity,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            18.verticalSpace,
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.darkColor,
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items ($itemsCount):',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.grayColor),
                ),
                Text(
                  '\$${cartData.total ?? "0.00"}',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkColor,
                  ),
                ),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping:',
                  style: TextStyle(fontSize: 14.sp, color: AppColors.grayColor),
                ),
                Text(
                  'Free',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            14.verticalSpace,
            Divider(color: AppColors.borderColor),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Payment:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkColor,
                  ),
                ),
                Text(
                  '\$${cartData.total ?? "0.00"}',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            AppBotton(
              label: 'Confirm Order',
              bgcolor: AppColors.primaryColor,
              textcolor: Colors.white,
              onPressed: () {
                Navigator.pop(ctx);
                AppSnackBar.showSuccess(
                  context,
                  title: 'Order Confirmed!',
                  message: 'Your order has been placed successfully.',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final cubit = context.read<CartCubit>();
            final cartData = (state is GetCartSuccsess)
                ? state.cartData
                : cubit.currentCart;
            final count = cartData?.cartItems.length ?? 0;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkColor,
                  ),
                ),
                if (count > 0) ...[
                  6.horizontalSpace,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartActionSuccess) {
            AppSnackBar.showSuccess(
              context,
              title: 'Success',
              message: state.message,
            );
          } else if (state is CartActionError) {
            AppSnackBar.showError(
              context,
              title: 'Error',
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CartCubit>();

          // Initial Loading
          if (state is GetCartLoading && cubit.currentCart == null) {
            return const CartSkeleton();
          }

          // Error State with Retry
          if (state is GetCartError && cubit.currentCart == null) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 54.sp,
                      color: Colors.redAccent,
                    ),
                    14.verticalSpace,
                    Text(
                      'Failed to load cart',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkColor,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      state.message ??
                          'Please check your network and try again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grayColor,
                      ),
                    ),
                    20.verticalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 10.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () {
                        context.read<CartCubit>().getcartdata();
                      },
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final cartData = (state is GetCartSuccsess)
              ? state.cartData
              : cubit.currentCart;
          final items = cartData?.cartItems ?? [];

          // Empty Cart State
          if (items.isEmpty) {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () => context.read<CartCubit>().getcartdata(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 120.h),
                  CartEmptyState(
                    onStartShopping: () {
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

          // Populated Cart List with Bottom Checkout Bar
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () => context.read<CartCubit>().getcartdata(),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => 14.verticalSpace,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final isUpdating =
                          state is CartItemUpdating &&
                          state.cartItemId == item.itemId;

                      return CartItemCard(
                        item: item,
                        isUpdating: isUpdating,
                        onTap: () {
                          if (item.itemProductId != null) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.bookdetailsscreen,
                              arguments: item.itemProductId,
                            );
                          }
                        },
                        onIncrement: () {
                          if (item.itemId != null) {
                            cubit.updateItemQuantity(
                              cartItemId: item.itemId!,
                              quantity: item.itemQuantity + 1,
                            );
                          }
                        },
                        onDecrement: () {
                          if (item.itemId != null) {
                            if (item.itemQuantity > 1) {
                              cubit.updateItemQuantity(
                                cartItemId: item.itemId!,
                                quantity: item.itemQuantity - 1,
                              );
                            } else {
                              _confirmRemove(context, item);
                            }
                          }
                        },
                        onRemove: () => _confirmRemove(context, item),
                      );
                    },
                  ),
                ),
              ),

              // Bottom Sticky Checkout Bar
              CartBottomBar(
                total: cartData?.total ?? "0.00",
                itemCount: items.fold<int>(
                  0,
                  (sum, it) => sum + it.itemQuantity,
                ),
                onCheckout: () {
                  if (cartData != null) {
                    _showCheckoutSheet(context, cartData);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
