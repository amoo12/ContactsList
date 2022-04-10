import 'package:contact_list/src/contacts_feature/searchDelegate.dart';
import 'package:contact_list/src/data/data_service.dart';
import 'package:contact_list/src/models/contact.dart';
import 'package:contact_list/src/shared_widgets/custom_toast.dart';
import 'package:contact_list/src/shared_widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'contact_details_view.dart';
import 'new_contact.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  late FToast fToast;

  late List<Contact> contacts;

  late DataService ds;

  bool isDescending = false;

  getData() {
    final List<Contact> data = ds.getData();

    data.sort((a, b) {
      if (isDescending) {
        return b.user.compareTo(a.user);
      } else {
        return a.user.compareTo(b.user);
      }
    });

    setState(() {
      contacts = data;
    });
  }

  void addContact(contact) async {
    customProgressIdicator(context);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      contacts.add(contact);
      Navigator.restorablePopAndPushNamed(context, ContactListView.routeName);

      // show success toast
      fToast.init(context);
      showToast(context, fToast, "Contact Saved", 3);
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
          title: Row(
            children: [
              Text('Contacts'),
              Image.asset('assets/images/animation.gif', height: 60, width: 60),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchContacts());
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewContact(addContact: addContact),
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
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isDescending = !isDescending;
                        });
                        getData();
                      },
                      child: Row(
                        children: [
                          Text('Name'),
                          isDescending
                              ? Icon(Icons.arrow_drop_up)
                              : Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    Text('created'),
                  ]),
            ),
            Expanded(child: buildContactList(context, contacts)),
          ],
        ));
  }
}

Widget buildContactList(BuildContext context, List<Contact> contacts) {
  return contacts.isEmpty
      ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Contacts!!',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: SvgPicture.asset(
                'assets/images/empty.svg',
                height: MediaQuery.of(context).size.height * 0.3,
              ),
            ),
          ],
        )
      : ListView.builder(
          restorationId: 'contactListView',
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            final contact = contacts[index];

            return ListTile(
                title: Text(contact.user),
                leading: Hero(
                  tag: contact.checkInDate,
                  child: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                subtitle: Text(contact.phone),
                trailing: Text(
                  contact.checkInDate.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                onTap: () {
                  Navigator.restorablePushNamed(
                    context,
                    ContactDetailsView.routeName,
                    arguments: contact.toJson(),
                  );
                });
          },
        );
}
