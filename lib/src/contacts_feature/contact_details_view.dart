import 'package:contact_list/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactDetailsView extends StatelessWidget {
  ContactDetailsView({Key? key}) : super(key: key);

  // late final Contact contact;
  static const routeName = '/contact_details';

  @override
  Widget build(BuildContext context) {
    final contact = Contact.fromJson(
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Contact details'),
      ),
      // stack to show the image on top of the text
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 48.0),
                  padding: EdgeInsets.only(top: 48.0, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16.0),                    
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        contact.user,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        contact.phone,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.9),
                        ),
                      ),
                      Text(
                        'created: ' + contact.checkInDate,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                // text

                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 49.0,
                    child: Hero(
                      tag: contact.checkInDate + contact.user + contact.phone,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 40.0,
                        ),
                        radius: 48.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: SvgPicture.asset(
              'assets/images/information.svg',
              height: MediaQuery.of(context).size.height * 0.3,
              
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
