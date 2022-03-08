import 'package:flutter/material.dart';
import 'register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'show_data.dart';
import 'table.dart';

class Login extends StatelessWidget {


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home:Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children:[Column(
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "User Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),controller: usernameController,
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
                          var url = Uri.parse("http://192.168.1.18:3333/api/login/?format=json");
                          var request_body =
                          {
                            "username":usernameController.text , "password" : passwordController.text
                          };
                          var res = await http.post(url , body: request_body);
                          //var json_data = json.decode(res.body);

                          if(res.statusCode == 200)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>   TableApp()),
                            );
                          }
                          else
                          {

                          }
                        },
                        child: Text("Log In"),
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
                    Text("Don't have an account ?"),
                    Builder(
                        builder: (context) {
                          return TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  Register()),
                                );
                              },
                              child: Text("register"));
                        }
                    )
                  ],
                )
              ],
            ),],
          ),
        ),
      ),
    );
  }
}
