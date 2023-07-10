import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:smartdine_waiter/core/utils/app_colors.dart';

import 'package:smartdine_waiter/features/home_page_feature/data/model/waiter_table.dart';
import 'package:smartdine_waiter/features/home_page_feature/presentation/cubit/home_page_cubit.dart';
import 'package:smartdine_waiter/features/home_page_feature/presentation/pages/components/homepage_colors.dart';

import 'package:smartdine_waiter/features/restaurant_home/presentation/cubit/restaurant_cubit.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/widgets/loading_widget.dart';
import 'package:smartdine_waiter/injection_container.dart' as di;
import 'package:smartdine_waiter/injection_container.dart';

import '../../../../core/utils/constant.dart';

import '../../../order_manage/presentation/cubit/order_manage_cubit.dart';
import '../../../restaurant_home/presentation/pages/restaurant_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<WaiterTable> tables = [];

  List<WaiterTable> filteredTables = [];
  List<WaiterTable> selectedTables = [];

  final HomePageCubit _homePageCubit = sl<HomePageCubit>();

  void toggleTableSelection(WaiterTable table) {
    List<WaiterTable> updatedList = [...selectedTables];

    updatedList.map((t) => t.tableId!).toList().contains(table.tableId)
        ? updatedList.removeWhere((t) => t.tableId == table.tableId)
        : updatedList.add(table);

    setState(() {
      selectedTables = updatedList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('SmartDine Waiter'),
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: _homePageCubit..getAllRestaurantList(),
        builder: (context, state) {
          if (state is HomePageInitial) {
            return const SizedBox(
              height: 0,
            );
          }
          if (state is HomePageLoading) {
            return const LoadingWidget();
          }
          if (state is HomePageLoaded) {
            tables = state.restList;
            tables.sort((a, b) => a.tableCapacity!
                .compareTo(b.tableCapacity!));
            return Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: state.restList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (state.restList[index].isOccupied!) {
                              if (state.selectedTableId !=
                                  state.restList[index].tableId) {
                                _homePageCubit.updateSelectedTable(
                                    state.restList[index].tableId!);
                              } else {
                                _homePageCubit.updateSelectedTable('');
                              }
                            } else {
                              Fluttertoast.showToast(msg: 'Table is empty');
                            }
                          },
                          child: Container(
                            padding: state.selectedTableId ==
                                    (state.restList[index].tableId)
                                ? EdgeInsets.all(8)
                                : EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              border: state.selectedTableId ==
                                      (state.restList[index].tableId)
                                  ? Border.all(color: kPrimaryColor)
                                  : null,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: (state.restList[index].isOccupied! &&
                                        !state.restList[index].isOrderPlaced!)
                                    ? kCreamColor
                                    : state.restList[index].isOrderPlaced!
                                        ? klightGreen
                                        : Colors.black12,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColors.primaryTextColorBlue,
                                        child: Text(
                                          '${tables[index].tableCapacity}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      )
                                    ],),
                                  ),
                                  Image.asset(
                                    "assets/images/table.png",
                                    height: 100,
                                  ),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          workFirstLaterCap(
                                              state.restList[index].tableName ??
                                                  ""),
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          state.restList[index].isOccupied! &&
                                                  !state.restList[index]
                                                      .isOrderPlaced!
                                              ? "Occupied"
                                              : state.restList[index]
                                                      .isOrderPlaced!
                                                  ? 'Order Placed'
                                                  : "Empty",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Service Not Available at your place."),
            );
          }
        },
      ),
      floatingActionButton: BlocBuilder<HomePageCubit, HomePageState>(
          bloc: _homePageCubit,
          builder: (context, state) {
            if (state is HomePageLoaded) {
              return state.selectedTableId != ""
                  ? FloatingActionButton.extended(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        if (state.selectedTableId != "") {
                          final String slectedTableName = state.restList
                              .where((element) =>
                                  element.tableId == state.selectedTableId)
                              .first
                              .tableName!;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<OrderManageCubit>(
                                      create: (context) =>
                                          di.sl<OrderManageCubit>()),
                                  BlocProvider<RestaurantCubit>(
                                      create: (context) =>
                                          di.sl<RestaurantCubit>()
                                            ..getRestaurantDetails()),
                                ],
                                child: RestaurantHomePage(
                                    selectedTableId: state.selectedTableId,
                                    slectedTableName: slectedTableName),
                              );
                            }),
                          );
                        } else {
                          Fluttertoast.showToast(msg: 'Select table first');
                        }
                      },
                      backgroundColor: primaryColor,
                      label: Text('Add Order'),
                    )
                  : SizedBox.shrink();
            } else {
              return SizedBox.shrink();
            }
          }),
    ));
  }
}
