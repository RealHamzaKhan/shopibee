import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopibee/consts/consts.dart';
class ProfileController extends GetxController{
 var profileImagePath=''.obs;
 changeImage({context})async{
  try{
   final image=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
   if(image==null){return;}
   profileImagePath.value=image.path;
  }
  catch(e){
   VxToast.show(context, msg: "Unknown error occurred");
  }

 }
}