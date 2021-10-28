import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../env.dart';
import '../models/student.dart';
import '../widgets/form.dart';

class Edit extends StatefulWidget {
  final Student student;

  Edit({this.student});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  // Required for form validations
  final formKey = GlobalKey<FormState>();

  // Handles text onchange
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController bioController;
  TextEditingController occupationController;

  Future<http.Response> upDa() async {
    final response = await http.put(
      Uri.parse('https://ti-react-test.herokuapp.com/users/' + widget.student.id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          "name": nameController.text,
          "email": emailController.text,
          "bio": bioController.text,
          "occupation": occupationController.text

      }),
    );
    final items = json.decode(response.body);

    String jsonTags = jsonEncode(items);
    developer.log(
      'Response1'+ jsonTags,
      name: 'my.app.category',

    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final items = json.decode(response.body);
      String jsonTags = jsonEncode(items);
      developer.log(
        'Response'+ jsonTags,
        name: 'my.app.category',

      );
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }
  // Future<void> updateCurrentUserInformation() async {
  //
  //    String url = 'https://ti-react-test.herokuapp.com/users/' + widget.student.id.toString();
  //   await http.get(
  //     url,
  //     // body: {
  //     //   "id": widget.student.id.toString(),
  //     //   "name": nameController.text,
  //     //   "email": emailController.text,
  //     //   "bio": bioController.text,
  //     //   "occupation": occupationController.text
  //     // },
  //
  //   ).then((value) {
  //     final items = json.decode(value.body).cast<Map<String, dynamic>>();
  //
  //     String jsonTags = jsonEncode(items);
  //     developer.log(
  //       'log mez'+ jsonTags,
  //       name: 'my.app.category',
  //       error: value,
  //     );
  //
  //     print(url);
  //     print(value.body);
  //   });
  // }
  //
  // Http post request to update data
  Future editStudent() async {
    return await http.patch(
      "${Env.URL_PREFIX}/"+widget.student.id.toString(),
      body: {
        "id": widget.student.id.toString(),
        "name": nameController.text,
        "email": emailController.text,
        "bio": bioController.text,
        "occupation": occupationController.text
      },
    );
  }

  void _onConfirm(context) async {
    // await editStudent();
    // await updateCurrentUserInformation();
    upDa();
    // Remove all existing routes until the Home.dart, then rebuild Home.
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.student.name);
    bioController = TextEditingController(text: widget.student.bio);
    emailController = TextEditingController(text: widget.student.email);
    occupationController = TextEditingController(text: widget.student.occupation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: RaisedButton(
      //     child: Text('Submit'),
      //     color: Colors.blue,
      //     textColor: Colors.white,
      //     onPressed: () {
      //       _onConfirm(context);
      //     },
      //   ),
      // ),
      body: Container(
        // height: double.infinity,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: 30, top: 100, right: 30, bottom: 50),
        // height: double.infinity,
        // width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),

        child: Center(
          child: ListView(

            // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Padding(
                  padding: EdgeInsets.all(12),

                  child: AppForm(
                    formKey: formKey,
                    nameController: nameController,
                    bioController: bioController,
                    emailController: emailController,
                    occupationController: occupationController,

                  ),

                ),
                GFButton(

                    onPressed: () {
                      _onConfirm(context);
                    },
                    text:"Submit"

                ),
              ]
          ),

        ),

      ),
    );
  }
}
