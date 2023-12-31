
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/messages_screen/messages_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_profiescreen.dart';
import 'package:emart_seller/views/shop_screen/shop_setting_screen.dart';
import 'package:emart_seller/views/widgets/appbar_widget.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text.style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=> EditProfileScreen(
              username: controller.snapshotData['vendor_name'],
            ));
           }, icon: const Icon(Icons.edit)),
          TextButton(onPressed: ()async{
            await Get.find<AuthController>().signoutMethod(context);
            Get.offAll(()=> const LoginScreen());
          },
              child: normalText(text: logout))
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: loadingIndicator(circleColor: white));
          }else if(snapshot.hasError){
            return Center(child: Text('Error: ${snapshot.error}'),);
          }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return Center(child: Text('No Profile data available'),);
          }
          else{
            controller.snapshotData = snapshot.data!.docs[0];
            print("Profile data: ${controller.snapshotData.data()}");
            //print(controller.snapshotData);
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                  ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover,)
                   .box
                   .roundedFull.clip(Clip.antiAlias).make()
                   : Image.network(controller.snapshotData['imageUrl'].toString(), width: 100,)
                      .box.roundedFull.clip(Clip.antiAlias).make(),

                  //leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                  subtitle: normalText(text: "${controller.snapshotData['email']}"),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
          // profileButtonsIcons.length > 0 && profileButtonsTitles.length > 0
          // ? profileButtonsIcons.length
          //     : 0,
                    profileButtonsIcons.length,
                  (index) => ListTile(
                      onTap: (){
                        if(index >= 0 && index < profileButtonsIcons.length){
                          switch (index){
                            case 0:
                              Get.to(()=> const ShopSettings());
                              break;
                            case 1:
                              Get.to(()=> const MessagesScreen());
                              break;
                            default:
                          }
                        }
                      },
                      leading: Icon(profileButtonsIcons[index], color: white,),
                      title: normalText(text: profileButtonsTitles[index]),
                    )
                    ),
                  ),
                ),
              ],
            );
          }

        },
      ),

    );
  }
}
