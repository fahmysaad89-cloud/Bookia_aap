import 'package:bookiaa/core/routes/app_routes.dart';
import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookItem extends StatelessWidget {
  final Products? product;
  const BookItem({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.bookdetailsscreen,
          arguments: product?.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        width: 163.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                product?.image ?? "",
                width: 140.9.w,
                height: 175.h,
                fit: BoxFit.cover,
              ),
            ),
            20.67.verticalSpace,
            Text(
              product?.name ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            8.23.verticalSpace,
            Row(
              children: [
                Expanded(child: Text(product?.price ?? "")),
                IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
