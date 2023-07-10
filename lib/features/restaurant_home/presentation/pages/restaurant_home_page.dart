import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartdine_waiter/core/utils/app_colors.dart';
import 'package:smartdine_waiter/core/utils/ui_helper.dart';
import 'package:smartdine_waiter/core/widgets/custom_appbar.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_item_model.dart';
import 'package:smartdine_waiter/features/order_manage/presentation/cubit/order_manage_cubit.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/cubit/restaurant_cubit.dart';

import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/components/custom_divider_view.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/widgets/loading_widget.dart';

import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/widgets/menu_item.dart';

import 'package:smartdine_waiter/injection_container.dart';

import '../../../../core/utils/constant.dart';

class RestaurantHomePage extends StatefulWidget {
  const RestaurantHomePage(
      {Key? key, required this.selectedTableId, required this.slectedTableName})
      : super(key: key);
  final String selectedTableId;
  final String slectedTableName;

  @override
  State<RestaurantHomePage> createState() => _RestaurantState();
}

class _RestaurantState extends State<RestaurantHomePage> {
  final RestaurantCubit _restaurantCubit = sl<RestaurantCubit>();

  bool isSearch = false;
  List<OrderItemModel> orderItemList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<RestaurantCubit, RestaurantState>(
          bloc: _restaurantCubit..getRestaurantDetails(),
          builder: (context, state) {
            if (state is RestaurantLoading) {
              return const LoadingWidget();
            } else if (state is RestaurantLoaded) {
              if (state.orderModel != null &&
                  state.orderModel!.items!.isNotEmpty) {
                orderItemList.addAll(state.orderModel!.items!);
              }
              return Column(
                children: [
                  CustomAppBar(
                    title: '${state.restaurant.restaurantName}',
                  ),
                  const CustomDividerView(dividerHeight: 1.0),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 80.0,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: FaIcon(
                                            FontAwesomeIcons.utensils,
                                            color: Colors.black,
                                            size: 22.0,
                                          ),
                                        ),
                                        UIHelper.horizontalSpaceExtraSmall(),
                                        Text("Menu",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0))
                                      ],
                                    ),
                                  ),
                                  const CustomDividerView(
                                      dividerHeight: 0.5, color: Colors.black),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: state.categories.length > 0
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.categories.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                workFirstLaterCap(
                                                    state.categories[index]),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontSize: 22.0),
                                              ),
                                              UIHelper.verticalSpaceMedium(),
                                              ListView.separated(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return RestaurantMenuItem(
                                                      cubit: _restaurantCubit,
                                                      menuItem: state
                                                          .restaurantMenuItems
                                                          .where((element) =>
                                                              element
                                                                  .foodCategory ==
                                                              state.categories[
                                                                  index])
                                                          .toList()[i],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return const CustomDividerView(
                                                        dividerHeight: 0.5,
                                                        color: Colors.black);
                                                  },
                                                  itemCount: state
                                                      .restaurantMenuItems
                                                      .where((element) =>
                                                          element
                                                              .foodCategory ==
                                                          state.categories[
                                                              index])
                                                      .toList()
                                                      .length),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : Center(child: Text("No item found")),
                            ),
                            UIHelper.verticalSpace(
                              MediaQuery.of(context).size.height / 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is RestaurantMenuFailed) {
              return LoadingWidget();
            }
            return const LoadingWidget();
          },
        ),
        bottomSheet: BlocBuilder<RestaurantCubit, RestaurantState>(
          bloc: _restaurantCubit,
          builder: (context, state) {
            if (state is RestaurantLoaded) {
              if (state.orderModel != null &&
                  state.orderModel!.items!.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: ListTile(
                    onTap: () {
                      BlocProvider.of<OrderManageCubit>(context).addOrder(
                          state.orderModel!.items!,
                          widget.selectedTableId,
                          widget.slectedTableName);
                      Fluttertoast.showToast(msg: 'Order placed');
                      Navigator.of(context).pop();
                    },
                    title: Text(
                      "${state.orderModel!.items!.length} ITEM",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white, fontSize: 10.0),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            "Place Order",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        UIHelper.horizontalSpaceSmall(),
                        const FaIcon(
                          FontAwesomeIcons.caretRight,
                          color: Colors.white,
                          size: 15.0,
                        )
                      ],
                    ),
                  ),
                );
              } else {}
            } else if (state is RestaurantLoading) {
              return Container(
                height: 0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              );
            }
            return UIHelper.verticalSpace(0);
          },
        ),
      ),
    );
  }
}
