import 'package:check_in_list/src/data/data_service.dart';
import 'package:check_in_list/src/models/item.dart';
import 'package:check_in_list/src/sample_feature/sample_item_list_view.dart';
import 'package:flutter/material.dart';

class SearchItems extends SearchDelegate {
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
    List<Item> items = DataService()
        .getData()
        .where((item) => item.user.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return buildItemsList(items);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Item> items = DataService()
        .getData()
        .where((item) => item.user.toLowerCase().contains(query.toLowerCase()))
        .toList();
        
    return buildItemsList(items);
  }
}
