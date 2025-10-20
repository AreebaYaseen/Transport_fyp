import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transport_fyp/components/colors.dart';
import 'package:transport_fyp/components/round_button.dart';
import 'package:transport_fyp/components/utils.dart';
import 'package:transport_fyp/screens/home/home_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final String userName;
  signUp() {
    if (usernameController.text.isEmpty) {
      Utils.toastMessage('Please enter your name');
      return;
    }

    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString())
        .then((value) async {
      User? user = FirebaseAuth.instance.currentUser;

      // Update display name in Firebase Auth (optional)
      if (user != null) {
        await user.updateDisplayName(usernameController.text);
      }

      // Store user data in Realtime Database
      DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("users").child(user!.uid);

      // Add name to the users node
      await userRef.set({
        "name": usernameController.text.trim(),  // Key fix: Add name field
        "profileImage": ""  // Initialize empty or add later
      });

      setState(() {
        loading = false;
      });

      Utils.toastMessage('Signed up Successfully');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils.toastMessage(error.toString());
    });
  }




  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController;
    passwordController;
    usernameController;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Text(
                        'Please Signup to Continue!',
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mColor,
                          letterSpacing: 1.5,
                      ),
                                          ),
                    ),),
                  Form(
                    key: _formKey,
                    child: Column(

                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 16,
                              ),

                              filled: true,
                              fillColor: AppColors.mColor,
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
                              hintText: 'Enter your full name',
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintStyle:  GoogleFonts.roboto(
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 1.5,),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10)),
                        ),
                        const SizedBox(height: 15),

                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.alternate_email,
                                color: Colors.white,
                                size: 18,
                              ),

                              filled: true,
                              fillColor:  AppColors.mColor,
                              focusColor: AppColors.mColor,
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
                              hintStyle:  GoogleFonts.roboto(
                                fontSize: 13,
                                color: Colors.white,
                                letterSpacing: 1.5,),
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
                                fillColor:    AppColors.mColor,
                                focusColor: AppColors.mColor,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.mColor, width: 0.8),
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
                                hintStyle: GoogleFonts.roboto(
                                  fontSize: 13,
                                  color: Colors.white,
                                  letterSpacing: 1.5,),
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
                     const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                  RoundButton(
                      loading: loading,
                      title: 'Sign up',
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          signUp();
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Already have an Account?",
                                                  style:  GoogleFonts.roboto(fontSize: 13, color: AppColors.mColor),

          ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const LoginScreen()));
                          },
                          child:  Text(
                            'Login',
                            style:  GoogleFonts.roboto(fontSize: 13, color:AppColors.mColor),

                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
