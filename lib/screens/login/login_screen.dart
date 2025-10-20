import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transport_fyp/components/colors.dart';
import 'package:transport_fyp/components/round_button.dart';
import 'package:transport_fyp/screens/home/home_screen.dart';
import 'package:transport_fyp/screens/login/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController;
    passwordController;
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(


        backgroundColor: Colors.white,
        body: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text(
                          'Please Login to Continue!',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                  size: 18,
                                ),

                                filled: true,
                                fillColor: AppColors.mColor,
                                focusColor:AppColors.mColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.mColor, width: 0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.mColor, width: 0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.mColor, width: 0.8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'abcdef@gmail.com',
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                hintStyle:   GoogleFonts.roboto(
                              fontSize: 13,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 10)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ValueListenableBuilder(
                            valueListenable: _obsecurePassword,
                            builder: (context, value, child) {
                              return TextFormField(
                                style: const TextStyle(color: Colors.white),
                                obscureText: _obsecurePassword.value,
                                focusNode: passwordFocusNode,
                                controller: passwordController,
                                decoration: InputDecoration(

                                  filled: true,
                                  fillColor:  AppColors.mColor,
                                  focusColor: AppColors.mColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:AppColors.mColor, width: 0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: const OutlineInputBorder(),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: AppColors.mColor, width: 0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'at least 8 characters',
                                  hintStyle:  GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        _obsecurePassword.value =
                                            !_obsecurePassword.value;
                                      },
                                      child: Icon(
                                        _obsecurePassword.value
                                            ? CupertinoIcons.eye_slash
                                            : Icons.visibility,
                                        color: Colors.white,
                                        size: 17,
                                      )),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {

                                },
                                child:  Text(
                                  'Forgot Password?',
                                  style:  GoogleFonts.roboto(fontSize: 13, color: AppColors.mColor),
                                )),
                          ),
                        ],
                      ),
                    ),
                    RoundButton(
                        loading: loading,
                        title: 'Login',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an Account?",
                          style:  GoogleFonts.roboto(fontSize: 13, color: AppColors.mColor),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Text(
                              'Sign Up',
                              style:  GoogleFonts.roboto(fontSize: 13, color: AppColors.mColor),

                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
