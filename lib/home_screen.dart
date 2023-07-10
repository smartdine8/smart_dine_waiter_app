import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdine_waiter/base_state.dart';
import 'package:smartdine_waiter/core/utils/app_colors.dart';
import 'package:smartdine_waiter/features/home_page_feature/presentation/pages/home_page.dart';
import 'package:smartdine_waiter/features/order_manage/presentation/pages/order_history.dart';
import 'package:smartdine_waiter/home_cubit.dart';

final pages = [
  // add other screens here
  HomePage(),
  OrderHistory()
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = HomeCubit()..changeItemIndex(0);

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BaseState>(
        bloc: homeCubit,
        builder: (context, state) {
          if (state is StateOnSuccess) {
            return Scaffold(
              body: pages[homeCubit.currentPageIndex],
              bottomNavigationBar: Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        homeCubit.changeItemIndex(0);
                      },
                      icon: Icon(
                        Icons.home_outlined,
                        color: homeCubit.currentPageIndex == 0
                            ? Colors.white
                            : Colors.grey,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      enableFeedback: false,
                      onPressed: () {
                        homeCubit.changeItemIndex(1);
                      },
                      icon: Icon(
                        Icons.reorder,
                        color: homeCubit.currentPageIndex == 1
                            ? Colors.white
                            : Colors.grey,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ErrorWidget('Unable to load HomeScreen');
          }
        });
  }
}
