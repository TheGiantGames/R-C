import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  final String id;
  final String pass;
  const Home({ required this.id ,required this.pass});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String staffId = "";
  String username = "";

  Future<String> Login(String staffID, password) async {
    http.Response _response =
    await http.post(Uri.parse("http://192.168.116.1/R&C/v1/loginUser.php")
        , body: {
          "staffID" : staffID,
          "password" :password
        });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      setState(() {

        Map a = jsonDecode(_response.body);
        staffId = a['Staff ID'];
        username = a['Username'];
        print(a['Staff ID']);
        print(a['Username']);


        //list1.add(_response.body);
      });

    };
    return _response.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Login(widget.id, widget.pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.greenAccent, title: Text("Welcome"),),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("WELCOME"),
              Text( "Staff Id:- " +  staffId),
              Text("UserName:-"  + username)
            ],
          ),
        ),
      ),
    );
  }
}
