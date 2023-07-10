import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartdine_waiter/core/utils/app_colors.dart';
import 'package:smartdine_waiter/core/utils/ui_helper.dart';
import 'package:smartdine_waiter/core/widgets/veg_badge_view.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/data/models/restaurant_menu_item_model.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/cubit/restaurant_cubit.dart';

class RestaurantMenuItem extends StatefulWidget {
  final RestaurantMenuItemModel menuItem;
  final RestaurantCubit cubit;

  RestaurantMenuItem({
    Key? key,
    required this.menuItem,
    required this.cubit,
  }) : super(key: key);

  @override
  State<RestaurantMenuItem> createState() => _RestaurantMenuItemState();
}

class _RestaurantMenuItemState extends State<RestaurantMenuItem> {
  List<OrderItemModel> orderItemList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                VegBadgeView(
                  isVeg: widget.menuItem.isVeg!,
                ),
                UIHelper.horizontalSpaceMedium(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        widget.menuItem.foodItemName.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        "\u{20B9} ${widget.menuItem.foodItemPrice.toString()}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14.0),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        widget.menuItem.foodItemDesc.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 12.0,
                              color: Colors.grey[500],
                            ),
                      ),
                    ],
                  ),
                ),
                UIHelper.horizontalSpace(5),
                widget.menuItem.foodItemImage.toString().isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          widget.menuItem.foodItemImage.toString(),
                          width: 80.0,
                          height: 80.0,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          'https://w7.pngwing.com/pngs/1004/181/png-transparent-tableware-with-empty-plate-12-thumbnail.png',
                          width: 80.0,
                          height: 80.0,
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                          fit: BoxFit.cover,
                        ),
                      )
              ],
            ),
            UIHelper.verticalSpaceSmall(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isAddItem(widget.menuItem)
                    ? ElevatedButton(
                        onPressed: () {
                          updateCartItem(widget.menuItem, isAdd: true);
                        },
                        child: const Text('ADD +'),
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: primaryColor,
                          elevation: 0.0,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 38.0,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              child: const Icon(
                                Icons.remove,
                                color: primaryColor,
                                size: 24.0,
                              ),
                              onTap: () {
                                updateCartItem(widget.menuItem);
                              },
                            ),
                            const Spacer(),
                            Text(getQuantity(widget.menuItem).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: black)),
                            const Spacer(),
                            InkWell(
                              child: const Icon(
                                Icons.add,
                                color: primaryColor,
                                size: 24.0,
                              ),
                              onTap: () {
                                updateCartItem(widget.menuItem, isAdd: true);
                              },
                            )
                          ],
                        ),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  isAddItem(RestaurantMenuItemModel restaurantMenuItemModel) {
    return orderItemList
        .where((element) =>
            element.order_item_name == restaurantMenuItemModel.foodItemName)
        .isEmpty;
  }

  getQuantity(RestaurantMenuItemModel restaurantMenuItem) {
    try {
      return orderItemList
          .where((element) =>
              element.order_item_name == restaurantMenuItem.foodItemName)
          .first
          .order_item_quantity;
    } catch (e) {
      Exception(e.toString());
    }
  }

  getArrayOfCart() {
    List<OrderItemModel> list = [];
    for (var i = 0; i < orderItemList!.length; i++) {
      list.add(orderItemList[i]);
    }
    return list;
  }

  updateCartItem(RestaurantMenuItemModel restaurantMenuItem,
      {int state = 0, bool isAdd = false}) async {
    try {
      int? itemQuantity;
      List<OrderItemModel>? list = getArrayOfCart() ?? [];
      final int index = list!.indexWhere(
          (item) => item.order_item_name == restaurantMenuItem.foodItemName);
      if (index >= 0) {
        itemQuantity = getQuantity(restaurantMenuItem) ?? 1;
        print('itemQuantity::$itemQuantity');
        if (isAdd == true) {
          if (restaurantMenuItem.foodItemName != list[0].order_item_name) {
            list.clear();
          }
          if (state == 0) {
            list[index] = OrderItemModel(
                order_item_quantity: itemQuantity! + 1,
                order_item_name: restaurantMenuItem.foodItemName!,
                order_item_price: restaurantMenuItem.foodItemPrice!,
                is_veg: restaurantMenuItem.isVeg!);
          } else {
            list[index] = OrderItemModel(
                order_item_quantity: itemQuantity! + state,
                order_item_name: restaurantMenuItem.foodItemName!,
                order_item_price: restaurantMenuItem.foodItemPrice!,
                is_veg: restaurantMenuItem.isVeg!);
          }
        } else if (isAdd == false) {
          if (itemQuantity == 1) {
            list.removeAt(index);
          } else {
            list[index] = OrderItemModel(
                order_item_quantity: itemQuantity! - 1,
                order_item_name: restaurantMenuItem.foodItemName!,
                order_item_price: restaurantMenuItem.foodItemPrice!,
                is_veg: restaurantMenuItem.isVeg!);
          }
        }
      } else {
        if (list.isNotEmpty) {
          if (restaurantMenuItem.foodItemName != list[0].order_item_name) {
            list.clear();
          }
        }
        final OrderItemModel cartItemModel = OrderItemModel(
            order_item_quantity: 1,
            order_item_name: restaurantMenuItem.foodItemName!,
            order_item_price: restaurantMenuItem.foodItemPrice!,
            is_veg: restaurantMenuItem.isVeg!);
        list.add(cartItemModel);
      }

      orderItemList.clear();

      orderItemList.addAll(list);

      widget.cubit
          .updateOrderItem(orderItemList, restaurantMenuItem.foodItemName!);

      setState(() {});
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
