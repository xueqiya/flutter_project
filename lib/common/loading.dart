import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget{
    @override
    _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{
    @override
    Widget build(BuildContext context){
        return Container(
            constraints: BoxConstraints.expand(),
            color: Colors.black26,
            child: Opacity(
                opacity: 1,
                child: SpinKitWave(
                    color: Colors.blue,
                    size: 40.0,
                ),
            ),
        );
    }
}