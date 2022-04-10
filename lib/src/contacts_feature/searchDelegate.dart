import 'package:contact_list/src/data/data_service.dart';
import 'package:contact_list/src/models/contact.dart';

import 'package:flutter/material.dart';

import 'contact_list_view.dart';

class SearchContacts extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // return clear button
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Contact> contacts = DataService()
        .getData()
        .where((contact) => contact.user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return buildContactList(context, contacts);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> contacts = DataService()
        .getData()
        .where((contact) => contact.user.toLowerCase().contains(query.toLowerCase()))
        .toList();
        
    return buildContactList(context, contacts);
  }
}
