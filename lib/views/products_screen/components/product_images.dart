import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/views/widgets/text.style.dart';

Widget productImages({required label, onPress,}){
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100, 100).roundedSM.make();
}