
import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/text.style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: shopSettings, size: 16.0,),
        actions: [
          TextButton(onPressed: (){}, child: normalText(text: save,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(
              label: shopName, hint: nameHint,
            ),
            10.heightBox,
            customTextField(
              label: address, hint: shopAddressHint,
            ),
            10.heightBox,
            customTextField(
              label: mobile, hint: shopMobileHint,
            ),
            10.heightBox,
            customTextField(
              label: website, hint: shopWebsiteHint,
            ),
            10.heightBox,
            customTextField(
              isDesc: true,
              label: description, hint: shopDescHint,
            ),

          ],
        ),
      ),
    );
  }
}