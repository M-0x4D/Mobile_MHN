import 'package:flutter/material.dart';
import 'dart:convert';

class hacker_model {
  final String hacker_ip;
  final String router_ip;
  final String port;
  final String web_page;
  final String time;

  const hacker_model(
    this.hacker_ip,
    this.router_ip,
    this.port,
    this.web_page,
    this.time,
  );

  factory hacker_model.fromDocument(Map document) {
    return hacker_model(
      document['hacker_ip'],
      document['router_ip'],
      document['port'],
      document['web_page'],
      document['time'],
    );
  }
}
