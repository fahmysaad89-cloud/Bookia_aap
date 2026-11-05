import 'package:bookiaa/core/theme/app_colors.dart';
import 'package:bookiaa/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookiaa/features/cart/presentation/ui/cart_screen.dart';
import 'package:bookiaa/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookiaa/features/home/presentation/ui/home_screen.dart';
import 'package:bookiaa/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookiaa/features/profile/presentation/ui/profile_screen.dart';
import 'package:bookiaa/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentindex = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getsellerbooks(),
      child: HomeScreen(),
    ),

    BlocProvider(
      create: (context) => HomeCubit()..getsellerbooks(),
      child: HomeScreen(),
    ),

    BlocProvider(
      create: (context) => CartCubit()..getcartdata(),
      child: CartScreen(),
    ),

    BlocProvider(
      create: (context) => ProfileCubit()..Getprofiledata(),
      child: ProfileScreen(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentindex],
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (v) {
          setState(() {
            currentindex = v;
          });
        },
        type: .fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              colorFilter: ColorFilter.mode(
                currentindex == 0 ? AppColors.primaryColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),

            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.bookmark.svg(
              colorFilter: ColorFilter.mode(
                currentindex == 1 ? AppColors.primaryColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.category.svg(
              colorFilter: ColorFilter.mode(
                currentindex == 2 ? AppColors.primaryColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.profile.svg(
              colorFilter: ColorFilter.mode(
                currentindex == 3 ? AppColors.primaryColor : Colors.black,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
