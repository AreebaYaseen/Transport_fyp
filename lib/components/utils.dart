
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Utils {

  static toastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }
  static void feildFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static void flushBarErrorMessage (String message , BuildContext context){

    showFlushbar(context: context, flushbar: Flushbar(
      message: message,
      forwardAnimationCurve: Curves.decelerate,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(20),
      backgroundColor: Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      reverseAnimationCurve: Curves.easeInOut,
      positionOffset: 20,
      borderRadius: BorderRadius.circular(8),
      icon: const Icon(Icons.error,size: 28 ,color: Colors.white,),
      duration: const Duration(
        seconds: 3,
      ),
    )..show(context),
    );
  }

  static snackBar(String message, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message),
      ),
    );
  }
}