import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/features/book_details/data/models/book_details_model.dart';
import 'package:bookiaa/features/book_details/presentation/cubit/bookdetails_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? bookId;
  const BookDetailsScreen({super.key, this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int _quantity = 1;
  bool _isBookmarked = false;
  bool _isExpanded = false;

  int? get _effectiveId {
    if (widget.bookId != null) return widget.bookId;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) return args;
    return null;
  }

  double _parsePrice(String? priceStr, double? fallback) {
    if (fallback != null && fallback > 0) return fallback;
    if (priceStr == null || priceStr.isEmpty) return 0.0;
    // Strip non-numeric/currency characters if any
    final cleaned = priceStr.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  String _formatPrice(double value) {
    if (value == value.roundToDouble()) {
      return '\$${value.toInt()}';
    }
    return '\$${value.toStringAsFixed(2)}';
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        backgroundColor: AppColors.darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              _isBookmarked
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_remove_outlined,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                _isBookmarked
                    ? 'Saved to your wishlist!'
                    : 'Removed from wishlist.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddToCart(Data? details) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        backgroundColor: AppColors.darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                color: AppColors.primaryColor,
                size: 18.sp,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Added to cart!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_quantity ${_quantity > 1 ? "copies" : "copy"} of ${details?.name ?? "Book"}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.grayColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
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
      body: SafeArea(
        child: BlocBuilder<BookdetailsCubit, BookdetailsState>(
          builder: (context, state) {
            if (state is GetDetailsLoding || state is BookdetailsInitial) {
              return _buildSkeletonLoading();
            } else if (state is GetDetailsSuccess) {
              final details = state.details;
              if (details == null) {
                return _buildEmptyState();
              }
              return _buildContent(details);
            } else {
              return _buildErrorState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTopBar({VoidCallback? onBookmarkTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppBackButton(),
          Row(
            children: [
              _buildSquareButton(
                icon: _isBookmarked
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                iconColor: _isBookmarked
                    ? AppColors.primaryColor
                    : AppColors.darkColor,
                onTap: onBookmarkTap ?? _toggleBookmark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          width: 41.w,
          height: 41.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Icon(icon, size: 22.sp, color: iconColor),
        ),
      ),
    );
  }

  Widget _buildContent(Data details) {
    final originalPriceVal = _parsePrice(details.price, null);
    final hasDiscount = details.discount != null && details.discount! > 0;
    final effectivePriceVal = hasDiscount
        ? (details.priceAfterDiscount ?? originalPriceVal)
        : originalPriceVal;
    final isOutOfStock = details.stock != null && details.stock! <= 0;
    final maxAvailable = (details.stock != null && details.stock! > 0)
        ? details.stock!
        : 99;

    return Column(
      children: [
        _buildTopBar(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                16.verticalSpace,
                _buildBookCover(details),
                22.verticalSpace,
                // Book Title
                Text(
                  details.name ?? '',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mainFont.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkColor,
                    height: 1.25,
                  ),
                ),
                8.verticalSpace,
                // Category Tag
                if (details.category != null && details.category!.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      details.category!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                12.verticalSpace,
                // Rating row
                _buildRatingRow(),
                18.verticalSpace,
                // Quick info / stats cards
                _buildStatsCard(details, isOutOfStock),
                24.verticalSpace,
                // Description Section
                _buildDescriptionSection(details.description),
                24.verticalSpace,
              ],
            ),
          ),
        ),
        _buildBottomBar(
          details: details,
          effectivePrice: effectivePriceVal,
          originalPrice: originalPriceVal,
          hasDiscount: hasDiscount,
          isOutOfStock: isOutOfStock,
          maxAvailable: maxAvailable,
        ),
      ],
    );
  }

  Widget _buildBookCover(Data details) {
    final hasDiscount = details.discount != null && details.discount! > 0;
    final isBestSeller = details.bestSeller == 1;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Book shadow and container
        Container(
          width: 200.w,
          height: 280.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.darkColor.withValues(alpha: 0.18),
                blurRadius: 28,
                offset: const Offset(0, 14),
                spreadRadius: -4,
              ),
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: details.image != null && details.image!.isNotEmpty
                ? Image.network(
                    details.image!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        _buildImagePlaceholder(),
                  )
                : _buildImagePlaceholder(),
          ),
        ),

        // Best seller badge
        if (isBestSeller)
          Positioned(
            top: 12.h,
            left: -8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star_rounded, color: Colors.white, size: 14.sp),
                  4.horizontalSpace,
                  Text(
                    'BEST SELLER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

        // Discount badge
        if (hasDiscount)
          Positioned(
            top: 12.h,
            right: -8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xffE53935),
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffE53935).withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '-${details.discount}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 54.sp,
            color: AppColors.grayColor.withValues(alpha: 0.5),
          ),
          10.verticalSpace,
          Text(
            'Bookia',
            style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.grayColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            Icons.star_rounded,
            color: const Color(0xffFFB800),
            size: 18.sp,
          ),
        ),
        6.horizontalSpace,
        Text(
          '4.8',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.darkColor,
          ),
        ),
        6.horizontalSpace,
        Text(
          '(120+ reviews)',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.grayColor,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard(Data details, bool isOutOfStock) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Availability
          _buildStatItem(
            icon: isOutOfStock
                ? Icons.cancel_outlined
                : Icons.check_circle_outline_rounded,
            iconColor: isOutOfStock
                ? const Color(0xffE53935)
                : const Color(0xff2E7D32),
            title: isOutOfStock ? 'Sold Out' : 'In Stock',
            subtitle: isOutOfStock
                ? 'Unavailable'
                : '${details.stock ?? 1} available',
          ),
          _buildVerticalDivider(),
          // Category / Genre
          _buildStatItem(
            icon: Icons.auto_stories_outlined,
            iconColor: AppColors.primaryColor,
            title: 'Genre',
            subtitle: (details.category != null && details.category!.isNotEmpty)
                ? details.category!
                : 'General',
          ),
          _buildVerticalDivider(),
          // Shipping / Original
          _buildStatItem(
            icon: Icons.verified_outlined,
            iconColor: AppColors.primaryColor,
            title: 'Guarantee',
            subtitle: '100% Original',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22.sp),
          6.verticalSpace,
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.darkColor,
            ),
          ),
          2.verticalSpace,
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1.w,
      height: 34.h,
      color: AppColors.borderColor,
    );
  }

  Widget _buildDescriptionSection(String? description) {
    final text = (description != null && description.trim().isNotEmpty)
        ? description.trim()
        : 'No detailed description available for this book.';
    final isLong = text.length > 150;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Overview',
            style: AppTextStyles.tittelScreenFont.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        10.verticalSpace,
        AnimatedCrossFade(
          firstChild: Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: AppColors.darkGrayColor,
            ),
          ),
          secondChild: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.6,
              color: AppColors.darkGrayColor,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
        if (isLong)
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Read less' : 'Read more',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBottomBar({
    required Data details,
    required double effectivePrice,
    required double originalPrice,
    required bool hasDiscount,
    required bool isOutOfStock,
    required int maxAvailable,
  }) {
    final totalPrice = effectivePrice * _quantity;
    final totalOriginal = originalPrice * _quantity;

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 14.h,
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom + 6.h
            : 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Price and Quantity counter row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price display
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  4.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatPrice(totalPrice),
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor,
                        ),
                      ),
                      if (hasDiscount) ...[
                        8.horizontalSpace,
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            _formatPrice(totalOriginal),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.grayColor,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              // Quantity counter
              Container(
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  children: [
                    _buildCounterButton(
                      icon: Icons.remove_rounded,
                      isEnabled: _quantity > 1 && !isOutOfStock,
                      onTap: () {
                        if (_quantity > 1) {
                          setState(() => _quantity--);
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor,
                        ),
                      ),
                    ),
                    _buildCounterButton(
                      icon: Icons.add_rounded,
                      isEnabled: _quantity < maxAvailable && !isOutOfStock,
                      onTap: () {
                        if (_quantity < maxAvailable) {
                          setState(() => _quantity++);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          14.verticalSpace,

          // Add to Cart Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isOutOfStock ? null : () => _handleAddToCart(details),
              borderRadius: BorderRadius.circular(12.r),
              child: Ink(
                height: 52.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isOutOfStock
                      ? AppColors.grayColor
                      : AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isOutOfStock
                      ? null
                      : [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(alpha: 0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    10.horizontalSpace,
                    Text(
                      isOutOfStock ? 'Out of Stock' : 'Add to Cart',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 34.w,
        height: 34.w,
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 18.sp,
          color: isEnabled
              ? AppColors.darkColor
              : AppColors.grayColor.withValues(alpha: 0.4),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoading() {
    final mockData = Data(
      name: 'The Great Gatsby Book Edition',
      category: 'Classic Fiction',
      description:
          'This is a placeholder description that simulates the book overview while the actual data is loading from the server. It gives the user a smooth shimmer experience.',
      stock: 12,
      price: '250',
      priceAfterDiscount: 200,
      discount: 20,
      bestSeller: 1,
    );

    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          _buildTopBar(onBookmarkTap: () {}),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  16.verticalSpace,
                  Container(
                    width: 200.w,
                    height: 280.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  22.verticalSpace,
                  Text(
                    mockData.name!,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    mockData.category!,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  12.verticalSpace,
                  _buildRatingRow(),
                  18.verticalSpace,
                  _buildStatsCard(mockData, false),
                  24.verticalSpace,
                  _buildDescriptionSection(mockData.description),
                ],
              ),
            ),
          ),
          _buildBottomBar(
            details: mockData,
            effectivePrice: 200,
            originalPrice: 250,
            hasDiscount: true,
            isOutOfStock: false,
            maxAvailable: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Column(
      children: [
        _buildTopBar(onBookmarkTap: () {}),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_off_rounded,
                      size: 42.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    'Failed to load book',
                    style: AppTextStyles.tittelScreenFont.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    'Something went wrong while retrieving the book details. Please check your connection and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.darkGrayColor,
                      height: 1.5,
                    ),
                  ),
                  26.verticalSpace,
                  ElevatedButton.icon(
                    onPressed: () {
                      final id = _effectiveId;
                      if (id != null) {
                        context.read<BookdetailsCubit>().getdetails(id);
                      }
                    },
                    icon: Icon(
                      Icons.refresh_rounded,
                      size: 18.sp,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Try Again',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 28.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        _buildTopBar(onBookmarkTap: () {}),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 56.sp,
                  color: AppColors.grayColor,
                ),
                16.verticalSpace,
                Text(
                  'Book details not found',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
