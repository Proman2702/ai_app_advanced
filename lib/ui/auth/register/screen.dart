import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/ui/additional/custom_button.dart';
import 'package:ai_app/ui/auth/register/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterScreenModel model = context.watch<RegisterScreenModel>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 120),

                Text(
                  "Регистрация",
                  style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      color: CustomColors.main,
                      fontWeight: FontWeight.w800,
                      fontSize: 40,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                //_StepHeader(currentStep: model.step),

                const SizedBox(height: 35),
                //_InputWindow(currentStep: model.step),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      onTap: () {},
                      text: "Вернуться",
                      width: 140,
                      height: 40,
                      color: CustomColors.main,
                      fontSize: 18,
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
