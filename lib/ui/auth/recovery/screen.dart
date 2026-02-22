import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/ui/additional/custom_button.dart';
import 'package:ai_app/ui/async_helper.dart';
import 'package:ai_app/ui/auth/recovery/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecoveryScreen extends StatelessWidget {
  const RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RecoveryScreenModel>();

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
                SizedBox(height: 150),
                Text(
                  maxLines: 2,
                  "Восстановление пароля",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: CustomColors.main,
                      fontWeight: FontWeight.w900,
                      fontSize: 38,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Введите почту уже зарегистрированного аккаунта, который хотите восстановить",
                    style: TextStyle(color: CustomColors.main),
                  ),
                ),
                SizedBox(height: 20),
                //CustomTextField(controller: model.emailController),
                SizedBox(height: 200),
                CustomButton(
                  onTap: () async {
                    final success = await withLoadingDialog<bool>(
                        context: context,
                        action: () async {
                          return true;
                        });
                    if (!context.mounted) return;

                    if (!success) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(title: Text("model.errorMessage ?? Неизвестная ошибка")),
                      );
                    } else {
                      Navigator.of(context).pushNamedAndRemoveUntil("/", (_) => false);
                    }
                  },
                  text: "Восстановить",
                  width: 200,
                  height: 36,
                  color: CustomColors.main,
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
