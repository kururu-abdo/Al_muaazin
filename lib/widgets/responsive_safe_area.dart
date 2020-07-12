import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

typedef ResponsoveBuilder = Widget Function(
BuildContext context ,
Size size

);

class ResponsiveSafeArea extends StatelessWidget {
 final ResponsoveBuilder responsoveBuilder;

  const ResponsiveSafeArea({Key key, ResponsoveBuilder builder}) :responsoveBuilder=builder  , super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context  ,constraits){
        return responsoveBuilder(
context  ,constraits.biggest
        );
      }),
    );
  }
}