import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/features/cart/data/models/cart_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final bool isUpdating;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const CartItemCard({
    super.key,
    required this.item,
    required this.isUpdating,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        (item.itemProductDiscount != null && item.itemProductDiscount! > 0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SizedBox(
                width: 75.w,
                height: 105.h,
                child: (item.itemProductImage != null &&
                        item.itemProductImage!.isNotEmpty)
                    ? Image.network(
                        item.itemProductImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
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
            12.horizontalSpace,

            // Details & Actions
            Expanded(
              child: SizedBox(
                height: 105.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top: Title & Delete Button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.itemProductName ?? "Book",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkColor,
                              height: 1.25,
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        InkWell(
                          onTap: isUpdating ? null : onRemove,
                          borderRadius: BorderRadius.circular(20.r),
                          child: Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              Icons.close_rounded,
                              size: 18.sp,
                              color: AppColors.grayColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Discount Pill (if applicable)
                    if (hasDiscount)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          "${item.itemProductDiscount}% OFF",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // Bottom: Price & Stepper
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (hasDiscount &&
                                item.itemProductPriceAfterDiscount != null) ...[
                              Text(
                                "\$${item.itemProductPriceAfterDiscount!.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkColor,
                                ),
                              ),
                              Text(
                                "\$${item.itemProductPrice ?? ""}",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: AppColors.grayColor,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ] else
                              Text(
                                "\$${item.itemProductPrice ?? ""}",
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkColor,
                                ),
                              ),
                          ],
                        ),

                        // Quantity Stepper
                        if (isUpdating)
                          SizedBox(
                            width: 80.w,
                            height: 32.h,
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
                          Container(
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Decrement button
                                InkWell(
                                  onTap: onDecrement,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    child: Icon(
                                      item.itemQuantity == 1
                                          ? Icons.delete_outline_rounded
                                          : Icons.remove_rounded,
                                      size: 16.sp,
                                      color: item.itemQuantity == 1
                                          ? Colors.redAccent
                                          : AppColors.darkColor,
                                    ),
                                  ),
                                ),

                                // Quantity Number
                                Container(
                                  constraints: BoxConstraints(minWidth: 24.w),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${item.itemQuantity}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.darkColor,
                                    ),
                                  ),
                                ),

                                // Increment button
                                InkWell(
                                  onTap: onIncrement,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 16.sp,
                                      color: AppColors.darkColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

