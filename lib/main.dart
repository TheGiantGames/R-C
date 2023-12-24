

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(512,512),
      builder: (BuildContext context , child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _formKey = GlobalKey<FormState>();
  var staffIdController = TextEditingController();
  var passwordController = TextEditingController();
  late Map<String, dynamic>  res = {} ;


late List<String> list1 = [];
Map<String , dynamic> list = {};

//this function help to send the correct index
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
          //list1.add(_response.body);
        });

    };
    return _response.body;
  }


  
  postData(var staffID , password)async{
    final response = await http.post(Uri.parse("http://192.168.116.1/R&C/v1/loginUser.php"),
    body: {
      "staffID" : staffID,
      "password" :password
    });
    //print(response.body);
    setState(() {
      res = jsonDecode(response.body) as Map<String , dynamic>;
    });

    return jsonDecode(response.body);

    final data = await jsonDecode(response.body);
    print(data['error']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body:  Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h,),
              Text("Login" , style: TextStyle(fontSize: 50.sp , fontWeight: FontWeight.bold), ),
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
                          print(Login(staffIdController.text, passwordController.text));
                          print(list);


                        }
                      },
                      child: const Text('Submit'),
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
