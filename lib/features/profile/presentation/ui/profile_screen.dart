import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/core/theme/app_text_styles.dart';
import 'package:bookiaa/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookiaa/features/profile/presentation/ui/wedget/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        children: [
          const ProfileAppBar(),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is GetProfileError) {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    icon: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 45,
                    ),
                    title: const Text('Error'),
                    content: const Text(
                      'Please check your network.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          context.read<ProfileCubit>().Getprofiledata();
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is GetProfileSuccess) {
                final image = state.profileData?.image;
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: (image != null && image.isNotEmpty)
                          ? NetworkImage(image)
                          : null,
                      child: (image == null || image.isEmpty)
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.profileData?.name ?? "",
                            style: AppTextStyles.tittelScreenFont.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            state.profileData?.email ?? "",
                            style: AppTextStyles.hintTextFont.copyWith(
                              color: AppColors.darkGrayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is GetProfileError) {
                return const SizedBox.shrink();
              } else {
                // initial + loading
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
