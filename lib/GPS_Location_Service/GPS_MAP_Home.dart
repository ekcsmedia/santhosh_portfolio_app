import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'mymap.dart';

class GPSHomes extends StatefulWidget {

  @override
  _GPSHomesState createState() => _GPSHomesState();
}

class _GPSHomesState extends State<GPSHomes> {
// 1

  final loc.Location location = loc.Location();
  late String _locationId;

  @override
  void initState() {
    setState(() {
    //  _locationId = widget.name;
    });
    super.initState();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Location List',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body:
      Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('location')
                  .snapshots(),
              builder:
                  (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data!.docs[index]['name']
                            .toString()),
                        subtitle: Row(
                          children: [
                            Text(snapshot.data!.docs[index]['latitude']
                                .toString()),
                            SizedBox(
                              width: 20,
                            ),
                            Text(snapshot.data!.docs[index]['longitude']
                                .toString()),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.directions),
                          onPressed: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => MyMap(
                                      snapshot.data!.docs[index].id,)));
                            //  _locationId!.displayName.toString()
                          },
                        ),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}


