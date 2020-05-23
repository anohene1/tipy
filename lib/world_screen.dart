import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'size_config.dart';
import 'package:firebase_image/firebase_image.dart';


final postsRef = FirebaseDatabase.instance.reference().child('Customers available');//.child("b1Cs1R6yMVP9hFjM8mlwb7kv0192").child('Posts').orderByChild('timestamp');



List lists = [];



class WorldScreen extends StatefulWidget {




  static const id = 'world_screen';

  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('World', style: TextStyle(
            fontFamily: 'myriadpro',
            color: Colors.black
          ),),
          leading: IconButton(
              icon: Icon(Icons.close, color: Colors.green,),
              onPressed: (){
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          child: FutureBuilder(
              future: postsRef.once(),
              builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                if (snapshot.hasData) {
                  lists.clear();
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return new ListView.builder(
                      shrinkWrap: true,
                      itemCount: lists.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[200]))
                          ),
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(150),
                                      image: DecorationImage(image: FirebaseImage('gs://tipy-98639.appspot.com/profile_pic'))
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    image: DecorationImage(image: AssetImage('images/dp.png')),
                                    borderRadius: BorderRadius.circular(150)
                                ),
                              ),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('NAME', style: TextStyle(
                                        fontFamily: 'myriadpro',
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.blockSizeVertical * 1.7
                                    ),),
                                    SizedBox(height: SizeConfig.blockSizeVertical *  1,),
                                    Text(lists[index]["text"],
                                      maxLines: 20,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          fontFamily: 'myriadpro',
                                          fontSize: SizeConfig.blockSizeVertical * 1.7
                                      ),),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
                return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.green),),
                        Text('Loading your posts... 🕑',
                          style: TextStyle(
                              fontFamily: 'myriadpro'
                          ),
                        )
                      ],
                    ));
              }),
        ),
      ),
    );
  }
}
