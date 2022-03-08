import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';
import 'dart:async';


class TableApp extends StatefulWidget {
  @override
  _DataTableExample createState() => _DataTableExample();
}

class _DataTableExample extends State<TableApp> {

  Future<List> getusers() async {
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
            country: i['country']
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
    catch (e) {
      print(e);
    }
    return lst;
  }



  Future<List<hacker_model>> generateList() async {
    var url = Uri.parse("http://192.168.1.18:3333/api/data/?format=json");
    final response = await http.post(url);

    var list = await json.decode(response.body).cast<Map<String, dynamic>>();
    return await list.map<hacker_model>((json) =>hacker_model.fromDocument(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('DataTable'),
          ),
          body: Container(
              child: FutureBuilder<List>(
                future: getusers(),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    return ListView(
                      children:[ SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'id',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'router ip',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'country',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'time',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ) ,
                            DataColumn(
                              label: Text(
                                'web page',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'honeypot ip',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Delete',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                          rows: snapShot.data!.map<DataRow>((e) {
                            return DataRow(
                              cells: <DataCell>[
                                DataCell(Text('${e.id.toString()}')),
                                DataCell(Text('${e.router_ip}')),
                                DataCell(Text('${e.country}')),
                                DataCell(Text('${e.attach_time}')),
                                DataCell(Text('${e.web_bage}')),
                                DataCell(Text('${e.hacker_ip}')),
                                DataCell(Icon(Icons.delete)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),]
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              )),
        ),
      ),
    );
  }
}
