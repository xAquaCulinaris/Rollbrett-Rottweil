import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/app_localizations.dart';
import 'package:rollbrett_rottweil/login/register_view.dart';
import 'package:rollbrett_rottweil/reusable/rollbrett_logo.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class Login extends StatelessWidget {
  String _email = "";
  String _password = "";

  _loginButtonPressed() {
    print("Email: " + _email + "\n");
    print("Password: " + _password);
  }

  _setEmail(String text) {
    _email = text;
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
            SizedBox(height: 80),
            RollbrettLogo(),
            SizedBox(height: 40),
            CustomTextBox(
                labelText: "Email",
                icon: Icons.email,
                setText: _setEmail,
                textInputType: TextInputType.emailAddress),
            SizedBox(height: 15),
            CustomTextBox(
                labelText: AppLocalizations.of(context).translate('password'),
                icon: Icons.lock,
                setText: _setPassword,
                textInputType: TextInputType.text,
                isPassword: true),
            SizedBox(height: 60),
            Button(
                text: AppLocalizations.of(context).translate('login'),
                function: _loginButtonPressed),
            ForgotPasswordButton(),
            Spacer(),
            SignUpButton(context)
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  _forgotPassworButtonPressed() {
    print("forogt password pressed");
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
          Text(AppLocalizations.of(context).translate('no_account'), style:  TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black : Colors.grey)),
          TextButton(
              onPressed: _signUpButtonPressed,
              child: Text(
                AppLocalizations.of(context).translate('sign_up'),
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
        ]);
  }
}
