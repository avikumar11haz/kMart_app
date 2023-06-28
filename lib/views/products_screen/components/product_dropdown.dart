import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/views/widgets/text.style.dart';

Widget productDropdown() {
  return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        hint: normalText(text: "Choose category", color: fontGrey),
        value: null,
        isExpanded: true,
        items: const [],
        onChanged: (value){},
      ),
  ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make();
}