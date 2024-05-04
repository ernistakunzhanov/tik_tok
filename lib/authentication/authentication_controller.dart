import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_tok/authentication/login_view.dart';
import 'package:tik_tok/global.dart';
import 'package:tik_tok/home/home_view.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();

  late Rx<User?> _currentUser;

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
    try {
      // 1. create user in the firebase authentication
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail!,
        password: userPassword!,
      );
      // 2. save the user profile image to firebase storage
      String imageDownloadUrl = await uploadImageToStorage(imageFile);
      // 3. save user data to the firestore database
      userModel.User user = userModel.User(
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
        uid: credential.user!.uid,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set(user.toJson());
      Get.snackbar("Аккаунт создан успешно", 'Поздравляю вас!');
      showProgressBar = false;
    } catch (error) {
      Get.snackbar(
        "Создание учетной записи не удалось",
        'Произошла ошибка при создании учетной записи. Попробуйте еще раз.',
      );
      showProgressBar = false;
      Get.to(const LoginView());
    }
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

  void loginUserNow({
    String? userEmail,
    String? userPassword,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail!,
        password: userPassword!,
      );
      Get.snackbar("Авторизация прошло успешно", 'Вы успешно вошли в систему!');
      showProgressBar = false;
    } catch (error) {
      Get.snackbar(
        "Не удалось войти",
        'Произошла ошибка во время аутентификации входа.',
      );
      showProgressBar = false;
      Get.to(const LoginView());
    }
  }

  goToScreen(User? currentUser) {
    if (currentUser == null) {
      Get.offAll(const LoginView());
    } else {
      Get.offAll(const HomeView());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}
