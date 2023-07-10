import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/ui_helper.dart';

class LiveForFoodView extends StatelessWidget {
  const LiveForFoodView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.all(15.0),
      height: 400.0,
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'LIVE\nFOR\nFOOD',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.grey[400],
                  fontSize: 80.0,
                  letterSpacing: 0.2,
                  height: 0.8,
                ),
              ),
              UIHelper.verticalSpaceLarge(),
              Text(
                'MADE BY FOOD LOVERS',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
              ),

              UIHelper.verticalSpaceExtraLarge(),
              Row(
                children: <Widget>[
                  Container(
                    height: 1.0,
                    width: MediaQuery.of(context).size.width / 4,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
          Positioned(
            left: 180.0,
            top: 90.0,
            child: Image.asset(
              'assets/images/burger.png',
              height: 80.0,
              width: 80.0,
            ),
          )
        ],
      ),
    );
  }
}

class SeeAllRestaurantBtn extends StatelessWidget {
  const SeeAllRestaurantBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: primaryColor),
        child: Text(
          'See all restaurants',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white, fontSize: 19.0),
        ),
        onPressed: () {},
      ),
    );
  }
}
