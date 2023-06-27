import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/views/widgets/text.style.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
      onPressed: onPress,
      child: normalText(text: title, size: 16.0));
}