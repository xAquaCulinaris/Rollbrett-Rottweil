import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/app_bar.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/custom_dialog.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword(this.email);
  String email;


  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}



class _ForgotPasswordState extends State<ForgotPassword> {
  _setEmail(String text) {
    widget.email = text;
  }

  _resetPassword() {
    print("email: " + widget.email);
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
              textInputType: TextInputType.emailAddress,
              initialText: widget.email,),
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
