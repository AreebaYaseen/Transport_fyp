import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transport_fyp/components/colors.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/2,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.mColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.mColor,
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),

          child: Center(
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(

                backgroundColor: AppColors.mColor,
                shadowColor: AppColors.mColor,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),

                ),
              ),
              onPressed: () {  },
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
