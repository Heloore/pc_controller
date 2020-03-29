import 'package:flutter/material.dart';
import 'package:pc_controll/modules/touch_pad.dart';

class InputCard extends StatefulWidget {
  @override
  _InputCardState createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  Widget _buildMouse() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 250,
                color: Colors.blueGrey,
                child: TouchPad(),
              ),
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                print(details.delta);
              },
              child: Container(
                color: Colors.red,
                width: 50,
                height: 250,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, _) {
                    return Text(
                      "----",
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 70,
                color: Colors.yellow,
              ),
            ),
            Expanded(
              child: Container(
                height: 70,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildMouse(),
        Container(
            child: Column(
          children: <Widget>[
            Container(
              height: 70,
              width: 50,
              color: Colors.yellow,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 70,
                    color: Colors.yellow,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 70,
                    color: Colors.yellow,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 70,
                    color: Colors.yellow,
                  ),
                ),
              ],
            )
          ],
        )),
      ],
    );
  }
}
