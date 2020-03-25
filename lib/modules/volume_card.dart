import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class VolumeCard extends StatefulWidget {
  final int volumeLevel;

  const VolumeCard({Key key, this.volumeLevel = 0}) : super(key: key);
  @override
  _VolumeCardState createState() => _VolumeCardState();
}

class _VolumeCardState extends State<VolumeCard> {
  int volumeLevel;
  // Color trackColor;

  @override
  void initState() {
    volumeLevel = widget.volumeLevel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Volume level: $volumeLevel%",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 32,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    shape: StadiumBorder(),
                    child: Row(
                      children: <Widget>[
                        Icon(OMIcons.volumeOff, size: 50),
                        Text(
                          "Mute",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  Padding(padding: EdgeInsets.only(top: 30)),
                  FlatButton(
                    shape: StadiumBorder(),
                    child: Row(
                      children: <Widget>[
                        Icon(OMIcons.volumeUp, size: 50),
                        Text(
                          "Max",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              width: 100,
              child: FlutterSlider(
                tooltip: FlutterSliderTooltip(disabled: true),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.blue, Colors.red],
                    ),
                  ),
                  child: Icon(Icons.menu),
                ),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarHeight: 20,
                  inactiveTrackBarHeight: 15,
                  activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromRGBO(0 + (volumeLevel * 2.55).ceil(), 0,
                        255 - (volumeLevel * 2.55).ceil(), 1),
                  ),
                  inactiveTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.blue, Colors.red],
                    ),
                  ),
                ),
                axis: Axis.vertical,
                rtl: true,
                values: [0, 100],
                max: 100,
                min: 0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  setState(() {
                    volumeLevel = (lowerValue as double).ceil();
                  });
                },
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(right: 120, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  _buildBuildLevelControllButton("+1%", () {}),
                  _buildBuildLevelControllButton("-1%", () {}),
                ],
              ),
              Column(
                children: <Widget>[
                  _buildBuildLevelControllButton("+5%", () {}),
                  _buildBuildLevelControllButton("-5%", () {}),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildBuildLevelControllButton(String text, Function onTap) {
    return FlatButton(
      shape: StadiumBorder(),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 24,
        ),
      ),
    );
  }
}
