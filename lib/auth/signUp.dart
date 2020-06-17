import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email, password, password2, name;
  bool saveAttempt = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (textValue) {
                    setState(() {
                      name = textValue;
                    });
                  },
                  autovalidate: saveAttempt,
                  validator: (nameValue) =>
                      nameValue.isEmpty ? 'This field cannot be blank' : null,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                    ),
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (textValue) {
                    setState(() {
                      email = textValue;
                    });
                  },
                  autovalidate: saveAttempt,
                  validator: (emailValue) {
                    if (emailValue.isEmpty) {
                      return 'This field cannot be blank';
                    }
                    RegExp regExp = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                    if (regExp.hasMatch(emailValue)) {
                      return null;
                    }

                    return 'Please enter a valid email';
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                    ),
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (textValue) {
                    setState(() {
                      password = textValue;
                    });
                  },
                  autovalidate: saveAttempt,
                  validator: (pwValue) =>
                      pwValue.isEmpty ? 'This field cannot be blank' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  onChanged: (textValue) {
                    setState(() {
                      password2 = textValue;
                    });
                  },
                  autovalidate: saveAttempt,
                  validator: (pwValue2) =>
                      pwValue2.isEmpty ? 'This field cannot be blank' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3871AD),
                      ),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      saveAttempt = true;
                    });
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      _addPost();
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF3871AD),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Text(
                      'Enter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 54.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF3871AD),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addPost() async {
    String url = 'http://localhost:5000/register';
    print(name);
    Map map = {
      'name': name,
      'email': email,
      'password': password,
      'password2': password2
    };

    await apiRequest(url, map).then((authResult) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return new MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.white,
            ),
            home: Home(),
          );
        })));
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    // ignore: close_sinks
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
//    HttpClientResponse response = await request.close();
//
//    // todo - you should check the response.statusCode
//    String reply = await response.transform(utf8.decoder).join();
//    httpClient.close();
//    print(reply);
//    return reply;
    return 'done';
  }
}
