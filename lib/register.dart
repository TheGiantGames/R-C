import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:research_consulting/home.dart';




class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  var staffIdController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  //String error = "";
  String message = "";


  Future<String> Register(String staffID, username ,password  ) async {
    http.Response _response =
    await http.post(Uri.parse("http://192.168.116.1/R&C/v1/registerUser.php")
        , body: {
          "staffID" : staffID,
          "password" :password,
          "username" :username
        });
    print(_response.statusCode);
    if (_response.statusCode == 200) {
      setState(() {

        Map a = jsonDecode(_response.body);
        //error = a['error'];
        message = a['message'];
       print(a);


        //list1.add(_response.body);
      });

    };
    return _response.body;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body:  Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h,),
              Text("Register" , style: TextStyle(fontSize: 50.sp , fontWeight: FontWeight.bold), ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Staff Id',
                          hintText: 'Enter Staff ID',
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String staffID){

                        },
                        controller: staffIdController,
                        validator: (staffID){
                          if (staffID == null || staffID.isEmpty) {
                            return 'Please enter Staff ID';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h,),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Webmail Id ',
                          hintText: 'Enter Webmail Id',
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String staffID){

                        },
                        controller: usernameController,
                        validator: (staffID){
                          if (staffID == null || staffID.isEmpty) {
                            return 'Please enter Webmail Id';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h,),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String password){

                        },
                        controller: passwordController,
                        validator: (password){
                          if (password == null || password.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h,),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Register(staffIdController.text, usernameController.text, passwordController.text);
                            if(message == "Invalid Username or staff Id"){
                              Fluttertoast.showToast(
                                  msg: "Invalid Username or staff Id",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else if(message == "User Already registered"){
                              Fluttertoast.showToast(
                                  msg: "User Already registered",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }else if(message == "Registered Successfully"){
                                Fluttertoast.showToast(
                                msg: "Registered Successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                                );

                                Navigator.push(context , MaterialPageRoute(builder: (context) => Home(id: staffIdController.text , pass: passwordController.text,)));

                            }


                          }
                        },
                        child: const Text('Register'),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
