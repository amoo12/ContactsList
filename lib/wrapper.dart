import 'package:contact_list/src/contacts_feature/Introduction_screen/intro_screen.dart';
import 'package:contact_list/src/contacts_feature/contact_list_view.dart';
import 'package:contact_list/src/data/data_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  // check if this is the first luanch of the app
  bool isFirstLuanch(prefs) {
    if (!prefs.containsKey('isFirst')) {
      return true;
    } else {
      return prefs.getBool('isFirst');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isFirst = isFirstLuanch(snapshot.data);

            if (isFirst) {
              DataService.initData();
              return OnBoardingPage();
            } else {
              return ContactListView();
            } 

            // return isFirst ? OnBoardingPage() : ContactListView();
          } else {
            return Container(
                color: Theme.of(context).backgroundColor,
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )));
          }
        });
  }
}
