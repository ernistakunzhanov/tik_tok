import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tik_tok/authentication/authentication_controller.dart';
import 'package:tik_tok/authentication/login_view.dart';
import 'package:tik_tok/global.dart';
import 'package:tik_tok/widgets/input_text_widget.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final authenticationController = AuthenticationController.instanceAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Text(
                'Создать аккаунт',
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Начать сейчас',
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // change image
                  authenticationController.captureImageWithCamera();
                },
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                ),
              ),
              const SizedBox(height: 30),
              // user name input
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: userNameTextEditingController,
                  lableText: "Имя",
                  prefixIcon: Icons.person_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 25),
              // email input
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: emailTextEditingController,
                  lableText: "Аккаунт",
                  prefixIcon: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(height: 25),
              // passsword input
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: passwordTextEditingController,
                  lableText: "Пароль",
                  prefixIcon: Icons.lock_outline,
                  isObscure: true,
                ),
              ),
              const SizedBox(height: 30),
              showProgressBar == false
                  ? Column(
                      children: [
                        // signup button
                        Container(
                          width: MediaQuery.of(context).size.width - 38,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showProgressBar = true;
                              });

                              if (authenticationController.profieImage !=
                                      null &&
                                  userNameTextEditingController
                                      .text.isNotEmpty &&
                                  emailTextEditingController.text.isNotEmpty &&
                                  passwordTextEditingController
                                      .text.isNotEmpty) {
                                showProgressBar = true;
                                // create a new account for user
                                authenticationController
                                    .createAccountForNewUser(
                                  imageFile:
                                      authenticationController.profieImage,
                                  userName: userNameTextEditingController.text,
                                  userEmail: emailTextEditingController.text,
                                  userPassword:
                                      passwordTextEditingController.text,
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Already have an Account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // send user to signup screen
                                Get.to(const LoginView());
                              },
                              child: const Text(
                                'Войти',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(
                      //show animation
                      child: const SimpleCircularProgressBar(
                        progressColors: [
                          Colors.green,
                          Colors.blueAccent,
                          Colors.red,
                          Colors.amber,
                          Colors.purpleAccent,
                        ],
                        animationDuration: 3,
                        backColor: Colors.white38,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
