import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GpsPage extends StatefulWidget {
  GpsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GpsPageState createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  String _message = '已开启';
  bool gpsopen = true;
  String location = '';

  ///////////Flutter 调用原生 Start//////////////
  static const MethodChannel methodChannel =
      MethodChannel('samples.flutter.io/gps');

  Future<void> _inspection() async {
    String status = (gpsopen ? '开启' : '关闭');
    print('GPS 处于' + status + '状态');
  }

  Future<void> _open() async {
    setState(() {
      gpsopen = !gpsopen;
      _message = gpsopen ? '已开启' : '已关闭';
    });
    // await methodChannel.invokeMethod('openGPS');
  }

  Future<void> _getDate() async {
    // await methodChannel.invokeMethod('getDate');
    setState(() {
      location = '经度：121.443287, 纬度：31.03201';
    });
  }

  //////// Flutter 调用原生  End  ////////
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text('GPS Location'),
        ),
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('GPS状态:'), Text('$_message')],
              ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('检查GPS状态'),
                        onPressed: () {
                          showDialog<Null>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return new AlertDialog(
                                title: new Text('当前GPS状态'),
                                content: new SingleChildScrollView(
                                  child: new ListBody(
                                    children: <Widget>[
                                      new Text(gpsopen == true ? '开启' : '关闭'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  new FlatButton(
                                    child: new Text('确定'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((val) {
                            print(val);
                          });
                        },
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('开关GPS'),
                        onPressed: _open,
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('获取经纬度'),
                        onPressed: _getDate,
                      ),
                      Text('当前位置: ' + location),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
