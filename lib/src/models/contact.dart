import 'package:intl/intl.dart';

import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends HiveObject {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String phone;
  @HiveField(2)
  late final String checkIn;

  Contact(
      {
      required this.user,
      required this.phone,
      required this.checkIn});

  Contact.add({
       required this.user,
       required this.phone,
      }
      ){
      // format date to db format
      // format date to this format "2020-08-01 12:10:05"
        checkIn = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      }


  // to json
  Map<String, dynamic> toJson() => {
        'user': user,
        'phone': phone,
        'check-in': checkIn,
      };

  // convert from map to contact
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      user: json['user'] as String,
      phone: json['phone'] as String,
      checkIn: json['check-in'] as String,
    );
  }

  // format string to date
  String get checkInDate {
    DateTime date = DateTime.parse(checkIn);
    var fromat = DateFormat('d MMMM y hh:mm a');
    String formatted = fromat.format(date);
    return formatted;
  }

  

}
