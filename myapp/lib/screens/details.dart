import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

import '../env.dart';
import '../models/student.dart';
import './edit.dart';

class Details extends StatefulWidget {
  final Student student;

  Details({this.student});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void deleteStudent(context) async {
    await http.post(
      "${Env.URL_PREFIX}/delete.php",
      body: {
        'id': widget.student.id.toString(),
      },
    );
    // Navigator.pop(context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  // void confirmDelete(context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         content: Text('Are you sure you want to delete this?'),
  //         actions: <Widget>[
  //           RaisedButton(
  //             child: Icon(Icons.cancel),
  //             color: Colors.red,
  //             textColor: Colors.white,
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //           RaisedButton(
  //             child: Icon(Icons.check_circle),
  //             color: Colors.blue,
  //             textColor: Colors.white,
  //             onPressed: () => deleteStudent(context),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.delete),
          //   onPressed: () => confirmDelete(context),
          // ),
        ],
      ),
      body: Container(
        // width: 70,
        // width: 70,
        margin: EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 30),
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
        // height: 270.0,
        padding: const EdgeInsets.all(35),
 child: Container(
           child: ListView(

             // crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               GFCard(
                 boxFit: BoxFit.cover,
                 title: GFListTile(


                   // subTitle: Text('Card Sub Title'),
                 ),
                 content: Text(
                   " ${ widget.student.name == null? 'Loading ..': widget.student.name }",
                   style: TextStyle(fontSize: 40),
                 ),

               ),
               Text(
                 "Name : ${widget.student.name}",
                 style: TextStyle(fontSize: 20),
               ),
               Padding(
                 padding: EdgeInsets.all(10),
               ),
               Text(
                 "occupation : ${widget.student.occupation}",
                 style: TextStyle(fontSize: 20),
               ),
               Padding(
                 padding: EdgeInsets.all(10),
               ),
               Text(
                 "bio : ${widget.student.bio}",
                 style: TextStyle(fontSize: 20),
               ),
               Padding(
                 padding: EdgeInsets.all(10),
               ),
               Text(
                 "Email : ${widget.student.email}",
                 style: TextStyle(fontSize: 20),
               ),

               GFCard(
                 boxFit: BoxFit.cover,

                 buttonBar: GFButtonBar(
                   children: <Widget>[

                     GFButton(
                       onPressed: () => Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (BuildContext context) => Edit(student: widget.student),
                         ),
                       ),
                       text: 'Edit',
                     ),
                   ],
                 ),
               ),

             ],
           ),
         )


      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.edit),
      //   onPressed: () => Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (BuildContext context) => Edit(student: widget.student),
      //     ),
      //   ),
      // ),
    );
  }
}
