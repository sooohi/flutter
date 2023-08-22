/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannel extends StatefulWidget {
  const MethodChannel({Key? key}) : super(key: key);

  @override
  State<MethodChannel> createState() => _MethodChannelState();
}

class _MethodChannelState extends State<MethodChannel> {
  static const platform = const MethodChannel('phpl.com/value');

  String _value = 'null';

  Future<void> _getNativeValu() async{
    String value;
    try{
      value = await platform.invokeMethod('getValue');
    } on PlatformException catch(e) {
      value = '네이티브 코드 실행 에러 : ${e.message}';
    }


    setState((){
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MethodChannel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Text('네이티브 값'),
            RaisedButton(
              child: Text('$_value'),
              onPressed:_getNativeValu,

              },
            )
          ],
        ),
      ),
    );
  }
}
 */
