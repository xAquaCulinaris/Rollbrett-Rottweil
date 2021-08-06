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
  String _dropDownValue = "";

  _setUsername(String text) {
    _username = text;
  }

  _setEmail(String text) {
    _email = text;
  }

  _setDropDownValue(String text) {
    _dropDownValue = text;
  }

  _setPassword(String text) {
    _password = text;
  }

  _setConfirmPassword(String text) {
    _confirmPassword = text;
  }

  _registerButtonPressed() {
    print("reigster pressed");
    print("username: " + _username);
    print("email: " + _email);
    print("dropdownvalue: " + _dropDownValue);
    print("password: " + _password);
    print("confirm: " + _confirmPassword);
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
            child: RegisterTopBar(
              setUsername: _setUsername,
              setEmail: _setEmail,
              setPassword: _setPassword,
              setConfirmPassword: _setConfirmPassword,
              registerButtonPressed: _registerButtonPressed,
              setDropDownValue: _setDropDownValue,
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterTopBar extends StatelessWidget {
  const RegisterTopBar(
      {Key key,
      this.setUsername,
      this.setEmail,
      this.setPassword,
      this.setConfirmPassword,
      this.registerButtonPressed,
      this.setDropDownValue})
      : super(key: key);

  final Function setUsername;
  final Function setEmail;
  final Function setPassword;
  final Function setConfirmPassword;
  final Function registerButtonPressed;
  final Function setDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        RollbrettLogo(LogoSize.medium),
        SizedBox(height: 15),
        TextBoxes(
          setUsername: setUsername,
          setEmail: setEmail,
          setPassword: setPassword,
          setConfirmPassword: setConfirmPassword,
          registerButtonPressed: registerButtonPressed,
          setDropDownValue: setDropDownValue,
        ),
      ],
    );
  }
}

class TextBoxes extends StatelessWidget {
  const TextBoxes(
      {Key key,
      this.setUsername,
      this.setEmail,
      this.setPassword,
      this.setConfirmPassword,
      this.registerButtonPressed,
      this.setDropDownValue})
      : super(key: key);

  final Function setUsername;
  final Function setEmail;
  final Function setPassword;
  final Function setConfirmPassword;
  final Function registerButtonPressed;
  final Function setDropDownValue;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomTextBox(
          labelText: AppLocalizations.of(context).translate('username'),
          icon: Icons.person,
          setText: setUsername,
          textInputType: TextInputType.text),
      SizedBox(height: 15),
      CustomTextBox(
          labelText: "Email",
          icon: Icons.email,
          setText: setEmail,
          textInputType: TextInputType.emailAddress),
      SizedBox(height: 15),
      DropDownList(
        itemList: ["Skateboard", "BMX", "Scooter"],
        icon: Icons.accessible_forward,
        setDropDownValue: setDropDownValue,
      ),
      SizedBox(height: 15),
      CustomTextBox(
          labelText: AppLocalizations.of(context).translate('password'),
          icon: Icons.lock,
          setText: setPassword,
          textInputType: TextInputType.text),
      SizedBox(height: 15),
      CustomTextBox(
          labelText: AppLocalizations.of(context).translate('confirm_password'),
          icon: Icons.lock,
          setText: setConfirmPassword,
          textInputType: TextInputType.text),
      SizedBox(height: 15),
      Button(
        text: AppLocalizations.of(context).translate('REGISTER'),
        function: registerButtonPressed,
      ),
      SizedBox(height: 15)
    ]);
  }
}
