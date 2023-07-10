import 'package:flutter/material.dart';
import 'package:smartdine_waiter/core/widgets/veg_badge_view.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_item_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_theme.dart';
import '../../domain/entities/cart_entity.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel orderItemModel;

  const OrderItemTile({Key? key, required this.orderItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: VegBadgeView(
                isVeg: orderItemModel.is_veg,
              ),
            ),
            trailing: Text(
              '\u{20B9} ${int.parse(orderItemModel.order_item_quantity.toString()) * int.parse(orderItemModel.order_item_price.toString())}',
              style: appPrimaryTheme().textTheme.bodyText1,
            ),
            title: Text(
              "${orderItemModel.order_item_name.toString()} x ${orderItemModel.order_item_quantity}",
              style: appPrimaryTheme().textTheme.headline6,
              overflow: TextOverflow.ellipsis,
            )),
      ],
    );
  }
}
