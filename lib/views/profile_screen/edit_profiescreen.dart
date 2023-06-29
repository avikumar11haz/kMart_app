
import 'dart:io';

import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text.style.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: editProfile, size: 16.0,),
        actions: [
          controller.isloading.value ? loadingIndicator(circleColor: white)
              : TextButton(onPressed: ()async{
            controller.isloading(true);

            //if image is not selected
            if(controller.profileImgPath.value.isNotEmpty){
              await controller.uploadProfileImage();
            }else{
              controller.profileImageLink = controller.snapshotData['imageUrl'];
            }

            //if old password matches data base
            if(controller.snapshotData['password'] == controller.oldpassController.text){
              await controller.changeAuthPassword(
                  email: controller.snapshotData['email'],
                  password: controller.oldpassController.text,
                  newpassword: controller.newpassController.text);

              await controller.updateProfile(
                  imgUrl: controller.profileImageLink,
                  name: controller.nameController.text,
                  password: controller.newpassController.text);

              //ignore
              VxToast.show(context, msg: "Updated");
            }else if(controller.oldpassController.text.isEmptyOrNull &&
                controller.newpassController.text.isEmptyOrNull){
              await controller.updateProfile(
                  imgUrl: controller.profileImageLink,
                  name: controller.nameController.text,
                  password: controller.snapshotData['password']
              );
              VxToast.show(context, msg: "Updated");
            }else{
              VxToast.show(context, msg: "Some error occured");
              controller.isloading(false);
            }
          }, child: normalText(text: save,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // if data image url and controller path is empty
            controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty ?
            Image.asset(imgProduct, width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
            controller.snapshotData['imageUrl'] != '' && controller.profileImgPath.isEmpty ?
            Image.network(controller.snapshotData['imageUrl'],
              width: 100,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make()
                :
            Image.file(File(controller.profileImgPath.value),
              width: 100,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            //Image.asset(imgProduct, width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: white),
              onPressed: (){},
              child: normalText(text: changeImage, color: fontGrey),
            ),
            10.heightBox,
            const Divider(color: white,),
            customTextField(label: name, hint: "eg. ^v!_kumar", controller: controller.nameController),
            20.heightBox,
            Align(
                alignment: Alignment.centerLeft,
                child: boldText(text: "Change your password")),
            10.heightBox,
            customTextField(label: password, hint: passwordHint, controller: controller.oldpassController),
            10.heightBox,
            customTextField(label: confirmPass, hint: passwordHint, controller: controller.newpassController),
          ],
        ),
      ),
    ));
  }
}
