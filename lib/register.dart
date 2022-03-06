import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatelessWidget {

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children : [Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.perm_identity)),
                  controller: usernameController,
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  controller: emailController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                  controller: passwordController,
                ),
                SizedBox(
                  height: 40,
                ),
                Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: ()async
                        {
                          var url = Uri.parse("http://192.168.1.18:3333/api/register/?format=json");
                          var request_body =
                          {
                            "username":usernameController.text ,"email":emailController.text, "password" : passwordController.text
                          };
                          var res = await http.post(url , body: request_body);

                          if(res.statusCode == 200)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>   Login()),
                            );
                          }
                          else
                          {

                          }
                        },
                        child: Text("register"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity,
                              50), // double.infinity is the width and 30 is the height
                        ),
                      );
                    }
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("Do you have an account ?"),
                    Builder(
                        builder: (context) {
                          return TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  Login()),
                                );
                              },
                              child: Text("Log In"));
                        }
                    )
                  ],
                )
              ],
            ),],
          ),
        ),
      );
    //);
  }
}
