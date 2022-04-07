import 'package:intl/intl.dart';

class Item {
  final int? id;
  final String user;
  final String phone;
  final String checkIn;

  Item(
      {this.id,
      required this.user,
      required this.phone,
      required this.checkIn});

  // to json
  Map<String, dynamic> toJson() => {
        'user': user,
        'phone': phone,
        'check-in': checkIn,
      };

  // convert from map to item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
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
