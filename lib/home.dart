import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List keys = [];
  List values  = [];

  Future<String> Login(String staffID) async {
    http.Response _response =
    await http.post(Uri.parse("http://192.168.116.1/R&C/v1/projectDetails.php")
        , body: {
          "staffID" : widget.id,

        });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      setState(() {

        Map a = jsonDecode(_response.body);
        Iterable iterable = a.keys;
        Iterable iterable2 = a.values;
        keys = iterable.toList();
        values = iterable2.toList();


        //staffId = a['Staff ID'];
        //print(a['Staff ID']);
        //print(a['Username']);



        //list1.add(_response.body);
      });
      setState(() {

      });

    };
    return _response.body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Login(staffId);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.greenAccent, title: Text("Welcome"),),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text("WELCOME"),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text("Staff Id" + ":-" + widget.id),
          ),
          SizedBox(height: 20.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Text(keys[0] + ":- " + values[0].toString()),
                SizedBox(height: 5.h,),
                Text(keys[1] + ":- " + values[1].toString()),
                SizedBox(height: 5.h,),
                Text(keys[2] + ":- " + values[2].toString()),
                SizedBox(height: 5.h,),
                Text(keys[3] + ":- " + values[3].toString()),
                SizedBox(height: 5.h,),
                Text(keys[4] + ":- " + values[4].toString()),
                SizedBox(height: 5.h,),
                Text(keys[5] + ":- " + values[5].toString()),
                SizedBox(height: 5.h,),
                Text(keys[6] + ":- " + values[6].toString()),
                SizedBox(height: 5.h,),
                Text(keys[7] + ":- " + values[7].toString()),
                SizedBox(height: 5.h,),
                Text(keys[8] + ":- " + values[8].toString()),
                SizedBox(height: 5.h,),
                Text(keys[9] + ":- " + values[9].toString()),
                SizedBox(height: 5.h,),
                Text(keys[10] + ":- " + values[10].toString()),
                SizedBox(height: 5.h,),
                Text(keys[11] + ":- " + values[11].toString()),
                SizedBox(height: 5.h,),
                Text(keys[12] + ":- " + values[12].toString()),
                SizedBox(height: 5.h,),
                Text(keys[13] + ":- " + values[13].toString()),
                SizedBox(height: 5.h,),
                Text(keys[14] + ":- " + values[14].toString()),
                SizedBox(height: 5.h,),
                Text(keys[15] + ":- " + values[15].toString()),
                SizedBox(height: 5.h,),
                Text(keys[16] + ":- " + values[16].toString()),
                SizedBox(height: 5.h,),
                Text(keys[17] + ":- " + values[17].toString()),
              ],
            ),
          )
        ],
      )
    );
  }
}
