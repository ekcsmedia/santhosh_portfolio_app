import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
//import 'package:url_launcher/url_launcher.dart';

class ContactHome2 extends StatelessWidget {
  const ContactHome2({Key? key}) : super(key: key);

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
  List<Contact>? contacts;
  bool? _isChecked = false;
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text(
          "AlwarTeam.Com",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(width: 1000, height: 100,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "SELECT TEAM MEMBERS",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: (contacts) == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              itemCount: contacts!.length,
              itemBuilder: (BuildContext context, int index) {
                Uint8List? image = contacts![index].photo;
                String num = (contacts![index].phones.isNotEmpty) ? (contacts![index].phones.first.number) : "--";
                return ListTile(
                    leading: (contacts![index].photo == null)
                        ? const CircleAvatar(child: Icon(Icons.person))
                        : CircleAvatar(backgroundImage: MemoryImage(image!)),
                    title: Text(
                        "${contacts![index].name.first} ${contacts![index].name.last}"),
                    subtitle: Text(num),
                    trailing: Checkbox(
                        activeColor: Colors.green,
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value;
                          });
                        }
                    ),
                    onTap: () {
                      //          if (contacts![index].phones.isNotEmpty) {
                      //          launch('tel: ${num}');
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