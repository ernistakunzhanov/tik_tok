import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tik_tok/authentication/authentication_controller.dart';
import 'package:tik_tok/authentication/signup_view.dart';
import 'package:tik_tok/widgets/input_text_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final authenticationController = AuthenticationController.instanceAuth;
  bool showProgressBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset(
                'assets/images/tiktok.png',
                width: 200,
              ),
              Text(
                'Welcome',
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Glad to see you!',
                style: GoogleFonts.acme(
                  fontSize: 34,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
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
                              // login user now
                              if (emailTextEditingController.text.isNotEmpty &&
                                  passwordTextEditingController
                                      .text.isNotEmpty) {
                                setState(() {
                                  showProgressBar = true;
                                });
                                authenticationController.loginUserNow(
                                  userEmail: emailTextEditingController.text,
                                  userPassword:
                                      passwordTextEditingController.text,
                                );
                              }
                            },
                            child: const Center(
                              child: Text(
                                'Войти',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Don't have an Account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // send user to signup screen
                                Get.to(const SignupView());
                              },
                              child: const Text(
                                'Зарегистрироваться',
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
