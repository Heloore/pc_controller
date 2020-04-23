import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pc_controll/modules/settings/bloc/settings_bloc.dart';
import 'package:qrscan/qrscan.dart';

import '../../../main.dart';


// TODO: create separate screen for settings
class SettingsCard extends StatefulWidget {
  @override
  _SettingsCardState createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  final TextEditingController controller = TextEditingController();
  final SettingsBloc bloc = SettingsBloc();

  @override
  void dispose() {
    controller.dispose();
    // bloc.dispose();
    super.dispose();
  }

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
                    child: StreamBuilder<String>(
                        // stream: bloc.addressStream.stream,
                        builder: (context, snapshot) {
                          String value;
                          if (snapshot.hasData) {
                            print(snapshot.data);
                            value = snapshot.data;
                          } else {
                            print("no data");
                          }
                          return TextFormField(
                            controller: controller,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                            decoration: InputDecoration(hoverColor: Colors.white),
                            cursorColor: Colors.white,
                            // initialValue: value,
                            // onChanged: (String value) => _textValue = value,
                          );
                        }),
                  ),
                  IconButton(
                    iconSize: 24,
                    splashColor: Colors.white,
                    color: Colors.white,
                    icon: Icon(
                      Icons.save,
                    ),
                    onPressed: () async {
                      await _setApiPath(controller.text);
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
                String qr = await scan();
                if (qr != null) {
                  await _setApiPath(qr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setApiPath(String address) async {
    if (await bloc.saveNewAddress(address)) {
      // TODO: remove
      MyApp.myTabbedPageKey.currentState.animateToPage(1);
    } else {
      _showSnackBar("IP address is incorrect");
    }
  }

  _showSnackBar(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
