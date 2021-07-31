import 'package:flutter/material.dart';
import 'package:rollbrett_rottweil/login/rollbrett_logo.dart';
import 'package:rollbrett_rottweil/reusable/button.dart';
import 'package:rollbrett_rottweil/reusable/textBox.dart';

class Login extends StatelessWidget {
  String email = "";
  String password = "";

  _loginButtonPressed() {
    print("Email: " + email);
  }

  _setEmail(String text) {
    email = text;
  }

  _setPassword(String text) {
    password = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: new Column(
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
                labelText: "Password",
                icon: Icons.lock,
                setText: _setPassword,
                textInputType: TextInputType.text,
                isPassword: true),
            SizedBox(height: 60),
            Button(text: "LOGIN", function: _loginButtonPressed),
            ForgotPasswordButton(),
            Spacer(),
            SignUpButton()
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
    //TODO navigate register form
    return TextButton(
        onPressed: _forgotPassworButtonPressed,
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Theme.of(context).accentColor),
        ));
  }
}

class SignUpButton extends StatelessWidget {
  _signUpButtonPressed() {
    print("signup pressed");
  }

  @override
  Widget build(BuildContext context) {
    //TODO handle forgot password
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Dont't have a account?"),
          TextButton(
              onPressed: _signUpButtonPressed,
              child: Text(
                "Sign Up",
                style: TextStyle(color: Theme.of(context).accentColor),
              ))
        ]);
  }
}
