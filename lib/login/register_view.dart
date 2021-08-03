import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/reusable/dropdown_list.dart';
import 'package:rollbrett_rottweil/reusable/rollbrett_logo.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class Register extends StatelessWidget {
  String _username = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  _setUsername(String text) {
    _username = text;
  }

  _setEmail(String text) {
    _email = text;
  }

  _setPassword(String text) {
    _password = text;
  }

  _setConfirmPassword(String text) {
    _confirmPassword = text;
  }

  _registerButtonPressed() {
    print("reigster pressed");
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenHeight - keyboardHeight,
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  SafeArea(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              RollbrettLogo(),
              SizedBox(height: 15),
              CustomTextBox(
                  labelText: AppLocalizations.of(context).translate('username'),
                  icon: Icons.person,
                  setText: _setUsername,
                  textInputType: TextInputType.text),
              SizedBox(height: 15),
              CustomTextBox(
                  labelText: "Email",
                  icon: Icons.email,
                  setText: _setEmail,
                  textInputType: TextInputType.emailAddress),
              SizedBox(height: 15),
              DropDownList(
                itemList: ["Skateboard", "BMX", "Scooter"],
                icon: Icons.accessible_forward,
              ),
              SizedBox(height: 15),
              CustomTextBox(
                  labelText: AppLocalizations.of(context).translate('password'),
                  icon: Icons.lock,
                  setText: _setPassword,
                  textInputType: TextInputType.text),
              SizedBox(height: 15),
              CustomTextBox(
                  labelText: AppLocalizations.of(context)
                      .translate('confirm_password'),
                  icon: Icons.lock,
                  setText: _setConfirmPassword,
                  textInputType: TextInputType.text),
              SizedBox(height: 15),
              Button(
                text: AppLocalizations.of(context).translate('REGISTER'),
                function: _registerButtonPressed,
              ),
              SizedBox(height: 15)
            ],
          )),
        ),
      ),
    );
  }
}
