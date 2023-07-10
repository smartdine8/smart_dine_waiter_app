import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdine_waiter/features/order_manage/presentation/cubit/order_manage_cubit.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/cubit/restaurant_cubit.dart';
import 'package:smartdine_waiter/home_screen.dart';
import 'package:smartdine_waiter/injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<OrderManageCubit>(
              create: (context) => di.sl<OrderManageCubit>(),
            ),
            BlocProvider<RestaurantCubit>(
                create: (context) =>
                    di.sl<RestaurantCubit>()..getRestaurantDetails()),
          ],
          child: HomeScreen(),
        );
      }), (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Image.asset(
              "assets/images/smart_dine.png",
            ),
          ),
        ),
      ),
    );
  }
}
