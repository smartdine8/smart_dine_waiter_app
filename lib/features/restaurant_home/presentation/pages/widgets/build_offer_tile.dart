import 'package:flutter/material.dart';
import 'package:smartdine_waiter/core/utils/ui_helper.dart';

Padding buildOfferTile(BuildContext context, String desc) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.local_offer, color: Colors.red[600], size: 15.0),
          UIHelper.horizontalSpaceSmall(),
          Flexible(
            child: Text(
              desc,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontSize: 13.0),
            ),
          )
        ],
      ),
    );
