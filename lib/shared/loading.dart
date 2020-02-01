
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  Color color;
  double size;
  Loading({this.color, this.size});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: Center(
        child: SpinKitChasingDots(
          size: size != null ? size : 50,
          color: (color != null) ? color : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}