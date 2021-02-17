import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showTopFlash({BuildContext context, String message, String title}) async {
  showFlash(
    context: context,
    duration: const Duration(seconds: 5),
    persistent: true,
    builder: (context, controller) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Flash(
            controller: controller,
            backgroundColor: Colors.green[400],
            brightness: Brightness.light,
            boxShadows: [BoxShadow(blurRadius: 4)],
            barrierBlur: 4.0,
            barrierColor: Colors.black38,
            borderRadius: BorderRadius.circular(30),
            barrierDismissible: true,
            style: FlashStyle.floating,
            position: FlashPosition.top,
            child: FlashBar(
              padding: const EdgeInsets.all(40),
              title: Text(title, style: GoogleFonts.poppins(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600,),),
              message: Text(message, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600,),),
              showProgressIndicator: false,
              primaryAction: FlatButton(
                onPressed: () => controller.dismiss(),
                child: Text('DISMISS', style: GoogleFonts.poppins(fontSize: 24, color: Colors.amber[700], fontWeight: FontWeight.w600,),),
              ),
            ),
          ),
        ),
      );
    },
  );
}