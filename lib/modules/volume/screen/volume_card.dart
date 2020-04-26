import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:pc_controll/modules/volume/bloc/volume_bloc.dart';
import 'package:pc_controll/modules/volume/model/volume_model.dart';

class VolumeCard extends StatefulWidget {
  @override
  _VolumeCardState createState() => _VolumeCardState();
}

class _VolumeCardState extends State<VolumeCard> {
  final VolumeBloc bloc = VolumeBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VolumeModel>(
        stream: bloc.modelStream,
        builder: (context, AsyncSnapshot<VolumeModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: MaterialButton(
                onPressed: () {
                  bloc.getCurrentVolume();
                },
                child: Text(snapshot.error),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Volume level: ${snapshot.data.volume}%",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 32,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildRadicalLevelControllButton(
                            "Max",
                            Icon(OMIcons.volumeUp, size: 50),
                            () => bloc.setVolumeLevel(VolumeBloc.maxVolume),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15)),
                          _buildRadicalLevelControllButton(
                            "Mute",
                            Icon(OMIcons.volumeOff, size: 50),
                            () => bloc.setVolumeLevel(VolumeBloc.minVolume),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: <Widget>[
                              _buildLevelControllButton("+1%", () => bloc.setVolumeLevel(snapshot.data.volume + 1)),
                              _buildLevelControllButton("-1%", () => bloc.setVolumeLevel(snapshot.data.volume - 1)),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              _buildLevelControllButton("+5%", () => bloc.setVolumeLevel(snapshot.data.volume + 5)),
                              _buildLevelControllButton("-5%", () => bloc.setVolumeLevel(snapshot.data.volume - 5)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  // TODO: separate to widget
                  Container(
                    height: 300,
                    width: 100,
                    child: FlutterSlider(
                      jump: true,
                      selectByTap: true,
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
                          color: Color.fromRGBO(0 + (snapshot.data.volume * 2.55).ceil(), 0, 255 - (snapshot.data.volume * 2.55).ceil(), 1),
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
                      values: [VolumeBloc.minVolume.toDouble(), VolumeBloc.maxVolume.toDouble()],
                      max: VolumeBloc.maxVolume.toDouble(),
                      min: VolumeBloc.minVolume.toDouble(),
                      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                        bloc.setVolumeLevel((lowerValue as double).ceil());
                      },
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Widget _buildRadicalLevelControllButton(String text, Icon icon, Function onTap) {
    return FlatButton(
      shape: StadiumBorder(),
      child: Row(
        children: <Widget>[
          icon,
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 24,
            ),
          ),
        ],
      ),
      onPressed: onTap,
    );
  }

  Widget _buildLevelControllButton(String text, Function onTap) {
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
