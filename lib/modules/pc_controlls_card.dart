import 'package:flutter/material.dart';
import 'package:pc_controll/modules/widgets/controlls_buttons.dart';

class PCControllsCard extends StatefulWidget {
  @override
  _PCControllsCardState createState() => _PCControllsCardState();
}

class _PCControllsCardState extends State<PCControllsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 450,
          alignment: Alignment.center,
          color: Colors.blueGrey,
          child: ControlsButtons(
            onBottomTap: () {
              print("Bottom");
            },
            onCenterTap: () {
              print("Center");
            },
            onLeftTap: () {
              print("Left");
            },
            onRightTap: () {
              print("Right");
            },
            onTopTap: () {
              print("Top");
            },
            buttonWidth: 50,
          ),
        ),
      ],
    );
  }
}
