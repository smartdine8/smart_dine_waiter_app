import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/widgets/loading_widget.dart';
import 'package:smartdine_waiter/features/restaurant_home/presentation/pages/widgets/message_display.dart';
import 'package:smartdine_waiter/injection_container.dart' as di;

import '../cubit/order_manage_cubit.dart';
import '../widgets/order_card.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        foregroundColor: Colors.white,
        title: Text(
          "Orders",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(overflow: TextOverflow.ellipsis, color: Colors.white),
        ),

      ),
      body: BlocProvider(
        create: (context) => di.sl<OrderManageCubit>()..getOrderList(),
        child: BlocBuilder<OrderManageCubit, OrderManageState>(
          builder: (context, state) {
            if (state is OrderManageInitial) {
              return const MessageDisplay(message: "OrderManageInitial");
            } else if (state is OrderManageLoading) {
              return const LoadingWidget();
            } else if (state is OrderManageLoaded) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.listOrder.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderCard(
                        orderEntity: state.listOrder[index], index: index);
                  });
            } else if (state is OrderManageFailed) {
              return MessageDisplay(message: state.message.toString());
            }
            return const MessageDisplay(message: "Manage Order");
          },
        ),
      ),
    );
  }
}
