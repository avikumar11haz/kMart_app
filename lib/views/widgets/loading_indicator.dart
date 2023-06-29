import 'package:emart_seller/consts/consts.dart';

Widget loadingIndicator({circleColor = purpleColor}){
  return Center(
    child:  CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}