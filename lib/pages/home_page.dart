import 'package:flutter/material.dart';
import 'package:masak_kuy/pages/Tentang.dart';
import 'recipe_details.dart';
import 'package:masak_kuy/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback, this.post})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  final String post;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: const Text('Masak Kuy App')),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Masak Kuy"),
                accountEmail: Text("masakkuy@gmail.com"),
                decoration: BoxDecoration(color: Colors.indigo),
              ),
              ListTile(
                leading: new Icon(Icons.home),
                title: Text('HOME'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.info_outline),
                title: Text('TENTANG'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Tentang()),
                  );
                },
              ),
              Divider(
                height: 10.0,
                color: Colors.black,
              ),
              ListTile(
                  trailing: new Icon(Icons.account_circle),
                  title: Text('LOGOUT'),
                  onTap: signOut),
            ],
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('post').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                const Text('Loading');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot mypost = snapshot.data.documents[index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 350.0,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Material(
                                color: Colors.white,
                                elevation: 14.0,
                                shadowColor: Color(0x802196f3),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200.0,
                                          child: Image.network(
                                              '${mypost['gambar']}',
                                              fit: BoxFit.fill),
                                        ),
                                        SizedBox(height: 10.0),
                                        Text(
                                          '${mypost['nama']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                              child: Text("See"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeDetails('$mypost[index]')),
                                );
                              })
                        ],
                      );
                    });
              }
            }));
  }
}
