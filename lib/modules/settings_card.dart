import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pc_controll/connection_controller/connection.dart';
import 'package:flutter/services.dart';
import 'package:qrscan/qrscan.dart';

import '../main.dart';

class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  String _textValue = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.teal[600],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Please input the ip address of your PC. You can see it when you launch PC controll application that you downloaded on your PC. Above the QR code there will be your address." +
                    "You can type it in the text field or scan the QR code by clicking on QR icon below",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      decoration: InputDecoration(hoverColor: Colors.white),
                      cursorColor: Colors.white,
                      initialValue: _textValue,
                      onChanged: (String value) => _textValue = value,
                    ),
                  ),
                  IconButton(
                    iconSize: 24,
                    splashColor: Colors.white,
                    color: Colors.white,
                    icon: Icon(
                      Icons.save,
                    ),
                    onPressed: () async {
                      await _setApiPath(_textValue);
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: IconButton(
              iconSize: 100,
              splashColor: Colors.white,
              hoverColor: Colors.white,
              color: Colors.white,
              icon: Icon(
                MdiIcons.qrcode,
              ),
              onPressed: () async {
                var barcode = await scan();
                if (barcode != null) {
                  setState(() {
                    _textValue = barcode;
                  });
                  await _setApiPath(barcode);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setApiPath(String address) async {
    try {
      await ConnectionController().setApiPath(address);
      MyApp.myTabbedPageKey.currentState.animateToPage(1);
    } catch (e) {
      print(e);
      _showSnackBar("IP address is incorrect");
    }
  }

  _showSnackBar(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
