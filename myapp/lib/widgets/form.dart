import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class AppForm extends StatefulWidget {
  // Required for form validations
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController bioController;
  TextEditingController emailController;
  TextEditingController occupationController;

  AppForm({this.formKey, this.nameController,
    this.bioController, this.emailController, this.occupationController, child});

  @override
  _AppFormState createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  String _validateName(String value) {
    if (value.length < 3) return 'Name must be more than 2 charater';
    return null;
  }


  String _validateEmail(String value) {
    Pattern pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Must be a valid email';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Name'),
            validator: _validateName,
          ),
          TextFormField(
            controller: widget.occupationController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Occupation'),
            validator: _validateName,
          ),
          TextFormField(
            controller: widget.bioController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Bio'),
            validator: _validateName,
          ),
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Email'),
            validator: _validateEmail,
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),

        ],
      ),
    );;
  }
}