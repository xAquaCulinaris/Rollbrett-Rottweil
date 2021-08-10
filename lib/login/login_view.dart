import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/home_page.dart';
import 'package:rollbrett_rottweil/login/forgot_password_view.dart';
import 'package:rollbrett_rottweil/login/register_view.dart';
import 'package:rollbrett_rottweil/reusable/rollbrett_logo.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class Login extends StatelessWidget {
  String _email = "";
  String _password = "";

  _loginButtonPressed(BuildContext context) {
    print("Email: " + _email + "\n");
    print("Password: " + _password);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  _setEmail(String text) {
    _email = text;
  }

  String _getEmail() {
    return _email;
  }

  _setPassword(String text) {
    _password = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            RollbrettLogo(LogoSize.big),
            SizedBox(height: MediaQuery.of(context).size.height / 18),
            CustomTextBox(
                labelText: "Email",
                icon: Icons.email,
                setText: _setEmail,
                textInputType: TextInputType.emailAddress),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            CustomTextBox(
                labelText: AppLocalizations.of(context).translate('password'),
                icon: Icons.lock,
                setText: _setPassword,
                textInputType: TextInputType.text,
                isPassword: true),
            SizedBox(height: MediaQuery.of(context).size.height / 15),
            Button(
                text: AppLocalizations.of(context).translate('login'),
                function: () => _loginButtonPressed(context)),
            ForgotPasswordButton(context, _getEmail),
            Spacer(),
            SignUpButton(context)
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  ForgotPasswordButton(this.context, this._getEmail);

  final BuildContext context;
  final Function _getEmail;

  _forgotPassworButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ForgotPassword(_getEmail()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: _forgotPassworButtonPressed,
        child: Text(
          AppLocalizations.of(context).translate('forgot_password'),
          style: TextStyle(color: Theme.of(context).accentColor),
        ));
  }
}

class SignUpButton extends StatelessWidget {
  SignUpButton(this.context);

  final BuildContext context;

  _signUpButtonPressed() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Register()));
  }

  @override
  Widget build(BuildContext context) {
    //TODO handle forgot password
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context).translate('no_account'),
              style: TextStyle(
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.light
                      ? Colors.black
                      : Colors.grey)),
          TextButton(
              onPressed: _signUpButtonPressed,
              child: Text(
                AppLocalizations.of(context).translate('sign_up'),
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
        ]);
  }
}
