import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/app_bar.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_dialog.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  _setEmail(String text) {
    email = text;
  }

  _resetPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalizations.of(context).translate('password_reset'),
            description:
                AppLocalizations.of(context).translate('password_reset_message'),
            buttonText: "Okay",
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              text: AppLocalizations.of(context).translate('reset_password')),
          SizedBox(height: 30),
          CustomTextBox(
              labelText: "Email",
              icon: Icons.email,
              setText: _setEmail,
              textInputType: TextInputType.emailAddress),
          SizedBox(height: 15),
          Button(
            text: AppLocalizations.of(context).translate("reset"),
            function: _resetPassword,
          )
        ],
      ),
    );
  }
}
