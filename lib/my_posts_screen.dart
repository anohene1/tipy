import 'package:flutter/material.dart';
import 'size_config.dart';
import 'home_screen.dart';

class MyPostsScreen extends StatefulWidget {

  static const id = 'my_posts_screen';

  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.green,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text(
            'My Posts',
            style: TextStyle(
                fontFamily: 'myriadpro',
                fontSize: SizeConfig.blockSizeVertical * 2,
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }
}
