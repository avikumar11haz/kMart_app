import 'package:emart_seller/consts/consts.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //textController
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try{
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }


  //signout method
  signoutMethod(context) async{
    try{
      await auth.signOut();
    }catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

}