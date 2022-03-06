import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'models.dart';
import 'package:dio/dio.dart';
import 'dart:async';


class Hacker_data extends StatelessWidget {


  Future<List> getusers()async{
    List<hacker_model> lst = <hacker_model>[];
    try {

      var response;
      lst.clear();
     /* try {
        response = await Dio().post('http://192.168.1.18:3333/api/data/?format?json');
        print(response);
      } catch (e) {
        print(e);
        print('error mohamed');
      }*/


      var url = Uri.parse("http://192.168.1.18:3333/api/data/?format=json");
      var res = await http.post(url);
      var json_data = json.decode(res.body);

      for (var i in json_data['data']) {
       // print('mmm ');
        hacker_model mod = hacker_model(
          id: i["id"],
          hacker_ip: i["hacker_ip"],
          router_ip: i["router_ip"],
          port: i['port'],
          web_bage: i['web_bage'],
          attach_time: i['attach_time'],
        );
        lst.add(mod);
      }
      //print(lst);
//print lst data
      // for (var n in lst) {
      //   print(n.name);
      // }
      // print(lst.map((e) => e.email));

      return lst;
    }
    catch(e){
      print(e);
    }
    return lst;
  }

  //print(lst);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("hello mr mohamed"),
            automaticallyImplyLeading: false

        ),
        body: FutureBuilder<List>(
          future: getusers(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("loadding"),
                ),
              );
            }
            else
              {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (item, i) {
                    return Card(
                      color: Colors.blue,
                      child: ListTile(

                        leading: Text(snapshot.data![i].id.toString()),
                        title: Text(snapshot.data![i].attach_time),
                        onTap: () => print("data"),
                        trailing: Text(snapshot.data![i].router_ip),subtitle: Text(snapshot.data![i].port),
                      ),
                      margin: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    );
                  });
              }
          },
        ),
      );
    //);
  }
}
