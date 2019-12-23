import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetails extends StatelessWidget {

  final String post;

  RecipeDetails(this.post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep')),
        body: StreamBuilder(
            stream:Firestore.instance.collection('post').snapshots(),
            builder:(context,snapshot){
              if(!snapshot.hasData){
                const Text('Loading');
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index){
                      DocumentSnapshot mypost=snapshot.data.documents[index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 350.0,
                            child:Padding(
                              padding: EdgeInsets.only(top:8.0,bottom:8.0),
                              child:Material(
                                color: Colors.white,
                                elevation : 14.0,
                                shadowColor: Color(0x802196f3),
                                child: Center(child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:200.0,
                                      child: Image.network(
                                          '${mypost['gambar']}',
                                          fit :BoxFit.fill
                                      ),
                                    ),
                                  ],),
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );}
                );
              }
            }
        )
    );
  }
}

