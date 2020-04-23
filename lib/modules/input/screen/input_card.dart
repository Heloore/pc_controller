import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:pc_controll/modules/input/widgets/controlls_buttons.dart';
import 'package:pc_controll/modules/input/widgets/touch_pad.dart';

class InputCard extends StatefulWidget {
  @override
  _InputCardState createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  final FocusNode _focusNode = FocusNode();
  final KeyboardVisibilityNotification _keyboardVisibilityNotification = KeyboardVisibilityNotification();
  final TextEditingController _textEditingController = TextEditingController();

  int _listenerID;
  String _lastValue = "";

  void _textEditingListener() {
    if (_lastValue.length < _textEditingController.text.length) {
      // print(_textEditingController.text.substring(_lastValue.length)); new textx entered
      _lastValue = _textEditingController.text;
    } else if (_lastValue.length > _textEditingController.text.length) {
      for (int i = 0; i <= (_lastValue.length - _textEditingController.text.length); i++) {
        //do delete of text
      }
    }

    print(_textEditingController.text);
    // print(_textEditingController.text.substring(_lastValue.length));
    _lastValue = _textEditingController.text;
  }

  @override
  void initState() {
    _textEditingController.addListener(_textEditingListener);
    _listenerID = _keyboardVisibilityNotification.addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          _focusNode.unfocus();
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _keyboardVisibilityNotification.removeListener(_listenerID);
    _textEditingController.removeListener(_textEditingListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildMouse(),
        _buildControllsButtons(),
      ],
    );
  }

  Widget _buildMouse() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 200,
                color: Colors.blueGrey,
                child: TouchPad(),
              ),
            ),
          ],
        ),
        Container(
          height: 70,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  shape: StadiumBorder(),
                  onPressed: () {},
                  child: Text(
                    "LMB",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  shape: StadiumBorder(),
                  onPressed: () {},
                  child: Text(
                    "RMB",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildControllsButtons() {
    return Flexible(
      fit: FlexFit.tight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              icon: Icon(Icons.keyboard),
              onPressed: () {
                _focusNode.requestFocus();
              },
            ),
          ),
          Container(
            height: 0,
            width: 0,
            child: TextField(
              keyboardType: TextInputType.multiline,
              focusNode: _focusNode,
              controller: _textEditingController,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
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
              buttonWidth: 40,
              centralWidget: Align(
                alignment: Alignment.center,
                child: Text(
                  "Space",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
