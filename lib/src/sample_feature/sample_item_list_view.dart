import 'package:check_in_list/src/data/data_service.dart';
import 'package:check_in_list/src/models/item.dart';
import 'package:check_in_list/src/sample_feature/searchDelegate.dart';
import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
   const SampleItemListView({
    Key? key,
    // this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  // final List<SampleItem> items;
  DataService ds = DataService();

 late List<Item> items;

 bool isDescending = false;
 
  getData(){
    final List<Item> data = ds.getData();
    

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
  
 @override
  void initState() {
    
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check In List'),
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

        // shape: const ContinuousRectangleBorder(
        //   borderRadius:  BorderRadius.only(
        //     bottomLeft:  Radius.circular(50),
        //     bottomRight:  Radius.circular(50),
        //   ),
        //   ),
        ),
      
      body: Column(
        children: [

          Container( 

            height: MediaQuery.of(context).size.height * 0.05,
            padding: const EdgeInsets.only(left: 82, right: 10),
            // color: Colors.grey[200],
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),

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



 Widget buildItemsList(List<Item> items) {
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


