import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class PCControllsCard extends StatefulWidget {
  @override
  _PCControllsCardState createState() => _PCControllsCardState();
}

class _PCControllsCardState extends State<PCControllsCard> {
  Widget _buildIcon(Color color, IconData iconData) {
    return IconButton(
      iconSize: 100,
      icon: Icon(
        iconData,
        color: color,
      ),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildIcon(Colors.grey, Icons.lock),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildIcon(
              Colors.red,
              Icons.power_settings_new,
            ),
            _buildIcon(
              Colors.red,
              Icons.refresh,
            ),
          ],
        ),
        Transform.rotate(
          child: _buildIcon(
            Colors.green,
            OMIcons.brightness3,
          ),
          angle: pi / 4,
        ),
      ],
    );
  }
}
