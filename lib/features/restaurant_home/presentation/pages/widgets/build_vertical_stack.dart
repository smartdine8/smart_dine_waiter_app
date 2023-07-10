import 'package:flutter/material.dart';
import 'package:smartdine_waiter/core/utils/ui_helper.dart';

Expanded buildVerticalStack(
        BuildContext context, String title, String subtitle) =>
    Expanded(
      child: SizedBox(
        height: 60.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontSize: 15.0),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 13.0))
          ],
        ),
      ),
    );
