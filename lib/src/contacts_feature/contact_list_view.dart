import 'package:check_in_list/src/contacts_feature/searchDelegate.dart';
import 'package:check_in_list/src/data/data_service.dart';
import 'package:check_in_list/src/models/contact.dart';

import 'package:check_in_list/src/shared_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../settings/settings_view.dart';
import 'new_contact.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class ContactListView extends StatefulWidget {
   const ContactListView({
    Key? key,
    // this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  late FToast fToast;

 late List<Contact> items;
  
  late DataService ds;

 bool isDescending = false;
 
  getData(){
    final List<Contact> data = ds.getData();
    

      data.sort((a,b){
        if(isDescending){
          return b.user.compareTo(a.user);
        }else{
          return a.user.compareTo(b.user);
        }
      }
    );

      setState(() {
        items = data;
      });
  }

  void addItem(item) {
    setState(() {
      items.add(item);
      Navigator.pop(context);
      fToast.init(context);
      showToast(context, fToast, "Contact Saved",3);
    });
  }
  
 @override
  void initState() {
    super.initState();
    ds = DataService();
    fToast = FToast();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),


          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchItems());
            },
          ),
        ],

        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.pushNamed(context, NewContact.routeName);
          // push material page route

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewContact(
                addItem: addItem
              ),
            ),
          );

        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container( 
            height: MediaQuery.of(context).size.height * 0.05,
            padding: const EdgeInsets.only(left: 82, right: 10),
            color: Theme.of(context).primaryColorLight.withOpacity(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
              InkWell(
                onTap: (){
                setState(() {
                  isDescending = !isDescending;
                });
                getData();
              },
                child: Row(
                  children: [
                    Text('Name'),
                    isDescending ?Icon(Icons.arrow_drop_up) :Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
              Text('Check-in date'),
              ]
            ),
          ),
          Expanded(child: buildItemsList(items)),
        ],
      ),
    );
  }

 }

 Widget buildItemsList(List<Contact> items) {
    return ListView.builder(

      restorationId: 'ItemListView',
      
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        
        return ListTile(
          title: Text(item.user),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          subtitle: Text(item.phone),
          trailing: Text(item.checkInDate.toString(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          ),
          onTap: () {
            Navigator.restorablePushNamed(
              context,
              SampleItemDetailsView.routeName,
            );
          }
        );
      },
    );
  }


