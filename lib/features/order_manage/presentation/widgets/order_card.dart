import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdine_waiter/core/utils/app_colors.dart';
import 'package:smartdine_waiter/core/utils/ui_helper.dart';
import 'package:smartdine_waiter/features/order_manage/data/models/order_model.dart';

import '../../../../core/utils/app_theme.dart';
import '../cubit/order_manage_cubit.dart';
import 'order_item_tile.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderEntity;
  final int index;

  const OrderCard({Key? key, required this.orderEntity, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: orderEntity.is_delivered ? klightGreen : Colors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        elevation: 3.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: FittedBox(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.darken),
                          image: const AssetImage(
                            'assets/images/restaurant_order_image.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Restaurant : SmartDine',
                      overflow: TextOverflow.ellipsis,
                      style: appPrimaryTheme().textTheme.headline5,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    UIHelper.verticalSpaceLarge(),
                    Text(
                      'Table : ${orderEntity.table_name}',
                      overflow: TextOverflow.ellipsis,
                      style: appPrimaryTheme().textTheme.headline5,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    UIHelper.verticalSpaceLarge(),
                    Text(
                      'Order ID : ${orderEntity.order_id}',
                      overflow: TextOverflow.ellipsis,
                      style: appPrimaryTheme().textTheme.headline5,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: orderEntity.items!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return OrderItemTile(
                      orderItemModel: orderEntity.items![index]!);
                }),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \u{20B9} ${orderEntity.total_amount}',
                  style: appPrimaryTheme().textTheme.bodyText1,
                ),
              ),
            ),
            !orderEntity.is_delivered
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<OrderManageCubit>(context)
                            .updateOrder(orderEntity);
                      },
                      child: const Text('Mark as completed'),
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: kPrimaryColor200,
                        elevation: 0.0,
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
