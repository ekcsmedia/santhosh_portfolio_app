import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

void main() => runApp(ContactHome());


class ContactHome extends StatelessWidget {
  const ContactHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late var _suggestions = <Contact>[];
  late final _saved = <Contact>[];
  late var saved = <Contact>[];

  get () {
    saved = _saved;
  }


  List<Contact>? contacts;

  //bool? _isChecked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      print(contacts);
      setState(() {
        _suggestions = contacts!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu,),
        title: const Text(
          "AlwarTeam.Com",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
            },
            tooltip: 'Saved Suggestions',
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(width: 1000, height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _saved.length < 1
                    ? "SELECT TEAM MEMBERS"
                    : "${_saved.length} Item Selected" ,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: (_suggestions) == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                Uint8List? image = _suggestions[index].photo;
                String num = (_suggestions[index].phones.isNotEmpty)
                    ? (_suggestions[index].phones.first.number)
                    : "--";

                final alreadySaved = _saved.contains(_suggestions[index]);


                return ListTile(
                    leading: (_suggestions[index].photo == null)
                        ? const CircleAvatar(child: Icon(Icons.person))
                        : CircleAvatar(backgroundImage: MemoryImage(image!)),
                    title: Text(
                        "${_suggestions[index].name.first} ${_suggestions[index]
                            .name.last}"),
                    subtitle: Text(num),
                    trailing: Icon(
                      alreadySaved ? Icons.check_box : Icons
                          .check_box_outline_blank,
                      color: alreadySaved ? Colors.red : null,
                      semanticLabel: alreadySaved
                          ? 'Remove from saved'
                          : 'Save',),
                    onTap: () {
                      setState(() {
                        if (alreadySaved) {
                          _saved.remove(_suggestions[index]);
                        } else {
                          _saved.add(_suggestions[index]);
                        }
                      });
                    }
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}