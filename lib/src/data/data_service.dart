import 'dart:io';

import 'package:contact_list/src/models/contact.dart';
import 'package:hive/hive.dart';



List<Map<String, dynamic>> dataSet = [
  {
    "user": "ChanSawLin",
    "phone": "0152131113",
    "check-in": "2020-06-30 16:10:05"
  },
  {
    "user": "LeeSawLoy",
    "phone": "0161231346",
    "check-in": "2020-07-11 15:39:59"
  },
  {
    "user": "KhawTongLin",
    "phone": "0158398109",
    "check-in": "2020-08-19 11:10:18"
  },
  {
    "user": "LimKokLin",
    "phone": "0168279101",
    "check-in": "2020-08-19 11:11:35"
  },
  {
    "user": "LowJunWei",
    "phone": "0112731912",
    "check-in": "2020-08-15 13:00:05"
  },
  {
    "user": "YongWengKai",
    "phone": "0172332743",
    "check-in": "2020-07-31 18:10:11"
  },
  {
    "user": "JaydenLee",
    "phone": "0191236439",
    "check-in": "2020-08-22 08:10:38"
  },
  {
    "user": "KongKahYan",
    "phone": "0111931233",
    "check-in": "2020-07-11 12:00:00"
  },
  {
    "user": "JasmineLau",
    "phone": "0162879190",
    "check-in": "2020-08-01 12:10:05"
  },
  {
    "user": "ChanSawLin",
    "phone": "016783239",
    "check-in": "2020-08-23 11:59:05"
  }
];

class DataService {

  DataService();

  static void initData() async {
    // add dataset to hive contact box
    var box = Hive.box<Contact>('contacts');
    for (var i = 0; i < dataSet.length; i++) {
      box.add(Contact.fromJson(dataSet[i]));
    }
  }
  
  // get all data
  List<Contact> getData() {
    // return dataSet.map((item) => Contact.fromJson(item)).toList();
    var box = Hive.box<Contact>('contacts');
    return box.values.toList();

  }

  // insert new item
  void insert(Contact contact) {
    // dataSet.add(contact.toJson());
    var box = Hive.box<Contact>('contacts');
    box.add(contact);

  }
}
