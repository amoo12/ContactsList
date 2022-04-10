import 'package:check_in_list/src/contacts_feature/contact_list_view.dart';
import 'package:check_in_list/src/data/data_service.dart';
import 'package:check_in_list/src/models/contact.dart';

import 'package:flutter/material.dart';

class SearchContacts extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
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
    // TODO: implement buildLeading
    // return back button
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

    return buildContactList(contacts);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> contacts = DataService()
        .getData()
        .where((contact) => contact.user.toLowerCase().contains(query.toLowerCase()))
        .toList();
        
    return buildContactList(contacts);
  }
}
