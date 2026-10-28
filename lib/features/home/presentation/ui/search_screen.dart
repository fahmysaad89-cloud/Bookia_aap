import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/widgets/app_back_button.dart';
import 'package:bookiaa/core/widgets/app_text_field.dart';
import 'package:bookiaa/features/home/data/models/books_models.dart';
import 'package:bookiaa/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/book_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(),
              24.verticalSpace,
              AppTextField(
                hint: 'Search Store',
                autofocus: true,
                onChanged: (v) {
                  context.read<HomeCubit>().search(v);
                },
              ),
              33.verticalSpace,

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
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
                                    'https://krinitsa.by/wp-content/themes/krinitsa/assets/i/no.png',
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is SearchSuccess) {
                      final products = state.products ?? [];

                      if (products.isEmpty) {
                        return const Center(child: Text('No books found'));
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
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 45,
                            ),
                            12.verticalSpace,
                            const Text(
                              'Search for books',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
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
