import 'package:flutter/material.dart';
import 'dart:convert';

class hacker_model {
  final int id;
  final String hacker_ip;
  final String router_ip;
  final String port;
  final String web_bage;
  final String attach_time;
  final String country;
  final String region;
  final String latitude;
  final String longitude;

   hacker_model({
    required this.id,
     required this.hacker_ip,
     required this.router_ip,
     required this.port,
     required this.web_bage,
     required this.attach_time,
     required this.country ,
     required this.region ,
     required this.latitude ,
     required this.longitude
});

  factory hacker_model.fromDocument(Map document) {
    return hacker_model(
      id:document['id'],
     hacker_ip: document['hacker_ip'],
     router_ip: document['router_ip'],
     port: document['port'],
    web_bage:  document['web_bage'],
     attach_time: document['attach_time'],
        country: document['country'] ,
      region: document['country'] ,
      latitude : document['latitude'] ,
      longitude : document['longitude']
     );
  }
}
