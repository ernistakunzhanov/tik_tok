import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();

  late Rx<File?> _pickedFile;
  File? get profieImage => _pickedFile.value;

  void chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "you have successfully selected your profile image.",
      );
    }
    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImageFile != null) {
      Get.snackbar(
        "Profile Image",
        "you have successfully capture your profile image with phone Camera.",
      );
    }
    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser({
    File? imageFile,
    String? userName,
    String? userEmail,
    String? userPassword,
  }) async {
    // 1. create user in the firebase authentication
    UserCredential credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail!,
      password: userPassword!,
    );
    // 2. save the user profile image to firebase storage
    String imageDownloadUrl = await uploadImageToStorage(imageFile);
    // 3. save user data to the firestore database
  }

  Future<String> uploadImageToStorage(File? imageFile) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('Profile Images')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(imageFile!);
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrlOfUploadimage = await taskSnapshot.ref.getDownloadURL();
    return downloadUrlOfUploadimage;
  }
}
