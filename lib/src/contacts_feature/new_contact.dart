import 'package:contact_list/src/data/data_service.dart';
import 'package:contact_list/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// widget with text fields to;
class NewContact extends StatefulWidget {
  const NewContact({
    Key? key,
    required this.addContact,
  }) : super(key: key);

  final Function addContact;
  static const routeName = '/new_contact';

  @override
  _NewContactState createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New Contact'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();

                Contact contact = Contact.add(
                  user: _nameController.text,
                  phone: _phoneController.text,
                );

                // insert contact to db
                DataService ds = DataService();
                ds.insert(contact);
                widget.addContact(contact);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Phone',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
