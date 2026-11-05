import 'package:bookiaa/features/cart/data/models/cart_response.dart';
import 'package:bookiaa/features/cart/presentation/ui/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartSkeleton extends StatelessWidget {
  const CartSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, _) => 14.verticalSpace,
        itemBuilder: (context, index) {
          return CartItemCard(
            item: const CartItem(
              itemProductName: 'Storytelling with Data',
              itemProductPrice: '229.00',
              itemProductPriceAfterDiscount: 148.85,
              itemProductDiscount: 35,
              itemQuantity: 2,
            ),
            isUpdating: false,
            onIncrement: () {},
            onDecrement: () {},
            onRemove: () {},
          );
        },
      ),
    );
  }
}
