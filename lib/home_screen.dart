


import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:login_app4/login_screen.dart';
import 'package:login_app4/my_posts_screen.dart';
import 'package:login_app4/my_replies_screen.dart';
import 'package:login_app4/profile_screen.dart';
import 'package:login_app4/sign_up_screen.dart';
import 'package:login_app4/size_config.dart';
import 'package:login_app4/tipy_icons_icons.dart';
import 'package:login_app4/tipy_theme.dart';
import 'package:login_app4/upload_screen.dart';
import 'package:login_app4/world_screen.dart';
import 'location.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart' as PlacePicker;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:firebase_image/firebase_image.dart';






final SweetSheet _sweetSheet = SweetSheet();


GoogleMapController mapController;

var newLatitude;
var newLongitude;
var postLat;
var postLong;

void getPostLatLong(String url)async{
  http.Response response = await http.get(url);
  String data = response.body;
  postLat = await jsonDecode(data)['result']['geometry']['location']['lat'];
  postLong = await jsonDecode(data)['result']['geometry']['location']['lng'];
}

void getLatLng(String url)async{
  http.Response response = await http.get(url);
  String data = response.body;

  newLatitude = jsonDecode(data)['result']['geometry']['location']['lat'];
  newLongitude = jsonDecode(data)['result']['geometry']['location']['lng'];
  print(newLongitude);
  print(newLatitude);
  print(data);
  moveMap(newLatitude, newLongitude);
}

void moveMap(double lat, double long){
  mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, long), zoom: 20)
      )

  );
}
String geometryURL = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$place_id&fields=geometry&key=AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48';

final _firestore = Firestore.instance;
String postText = postController.text;
enum Screen{list, map}
var placeID;
var place_id;
var Uid = loggedInUser.uid;

final _firebaseDB = FirebaseDatabase.instance;
final posts = _firebaseDB.reference().child('Customers available').child(Uid).child('Posts');
final comments = posts.child('Comments');
final allPosts = _firebaseDB.reference().child('World Posts');
final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

GoogleMapController _controller;

void getCurrentUser() async {
  try {
    final user = await _auth.currentUser();
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }catch(e){
    print(e);
  }
}

const kInactiveColor = Colors.transparent;
const kActiveColor = Colors.green;
const kActiveText = Colors.white;
const kInactiveText = Colors.green;

double latitude;
double longitude;

void getLocation() async{
  Locations location = Locations();
  await location.getCurrentLocation();
  longitude = location.longitude;
  latitude = location.latitude;
}

final postController = TextEditingController();
final snackBar = SnackBar(content: Text('Sending post...'));
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class HomeScreen extends StatelessWidget {

  static const String id = 'home_screen';
  static const kGoogleApiKey = 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48';





  @override
  Widget build(BuildContext context) {

    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48');

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }

  save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPrefs.setBool(key, value);
    } else if (value is String) {
      sharedPrefs.setString(key, value);
    } else if (value is int) {
      sharedPrefs.setInt(key, value);
    } else if (value is double) {
      sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      sharedPrefs.setStringList(key, value);
    }
  }








  TabController tabController;

  TextEditingController controller = TextEditingController();



  Icon toggleIcon = Icon(TipyIcons.crescent_moon, size: SizeConfig.blockSizeVertical * 2.5,);
  var theme = TipyTheme.lightTheme;
  Color col = Colors.black;
  Color textFieldColor = Colors.grey[200];
  bool isLight = true;
  Color sliderColor = Colors.white;
  Screen selectedScreen;


  saveThemePref(value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", value);
  }

  getThemePref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool themeValue = prefs.getBool("theme");
    return themeValue;
  }


  changeMapTheme(){
    getJsonFile("assets/datkmap.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async{
  return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle){
    _controller.setMapStyle(mapStyle);
  }




  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    getCurrentUser();
    getLocation();
    selectedScreen = Screen.map;



    Timer(Duration(seconds: 5), (){
      print(DateTime.now());

      _sweetSheet.show(
        context: context,
        title: Text('New Tip!', style: TextStyle( color: Colors.black, fontFamily: 'myriadpro', fontWeight: FontWeight.bold),),
        description: Text('Lorem ipsum dolor sit amet', style: TextStyle(color: Colors.black, fontFamily: 'myriadpro'),),
        color: CustomSheetColor(main: Colors.white, accent: Colors.white),
        positive: SweetSheetAction(
          onPressed: () {
            Navigator.of(context).pushNamed(UploadScreen.id);
          },
          title: 'Accept',
          color: Colors.green,
          accentColor: Colors.greenAccent,
        ),
        negative: SweetSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: 'Decline',
          color: Colors.red,
          accentColor: Colors.redAccent,
        ),
      );
    });




  }


  @override
  Widget build(BuildContext context) {





    return MaterialApp(
     theme: theme,
      home: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
        title: Container(
          width: SizeConfig.blockSizeHorizontal * 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              style: BorderStyle.solid,
              width: 1
            ),
            borderRadius: BorderRadius.circular(50)
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedScreen = Screen.list;
                    });
                  },
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 4,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Material(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
                        color: selectedScreen == Screen.list
                        ? kActiveColor
                        : kInactiveColor,
                        child: Center(
                          child: Text(
                            'List',
                            style: TextStyle(
                                color: selectedScreen == Screen.list
                                ? kActiveText
                                : kInactiveText,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontFamily: 'myriadpro'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedScreen = Screen.map;
                    });
                  },
                  child: Container(
                    height: SizeConfig.blockSizeVertical * 4,
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Material(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
                        color: selectedScreen == Screen.map
                        ? kActiveColor
                        : kInactiveColor,
                        child: Center(
                          child: Text(
                            'Map',
                            style: TextStyle(
                                color: selectedScreen == Screen.map
                                ? kActiveText
                                : kInactiveText,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontFamily: 'myriadpro'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
          actions: <Widget>[
            IconButton(icon: Icon(CupertinoIcons.search, ), onPressed: ()async{
              Prediction p = await PlacesAutocomplete.show(context: context, apiKey: 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48',
                  language: 'en',
                  mode: Mode.overlay,
                  components: [
                    Component(Component.country, 'gh')
                  ]
              );
              getLatLng('https://maps.googleapis.com/maps/api/place/details/json?place_id=${p.placeId}&fields=geometry,name&key=AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48');
              print(p.placeId);
              place_id = p.placeId;



            }),
          ],

          elevation: 5,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text('User One'),
                  accountEmail: Text(loggedInUser == null ? 'Loading...': loggedInUser.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: FirebaseImage('gs://tipy-98639.appspot.com/profile_pics/${loggedInUser.uid}'),
                ),
              ),
              ListTile(
                leading: Icon(TipyIcons.person, size: SizeConfig.blockSizeVertical * 3,),
                title: Text(
                  'Profile Options',
                  style: TextStyle(
                    fontFamily: 'myriadpro',
                    fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, ProfileScreen.id);
                },
              ),
              ListTile(
                leading: Icon(TipyIcons.gong, size: SizeConfig.blockSizeVertical * 3,),
                title: Text('Notification Options',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
                title: Text('Create Errand',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              Divider(),
              ListTile(
                onTap: (){
                  Navigator.pushNamed(context, WorldScreen.id);
                },
                leading: Icon(TipyIcons.globe, size: SizeConfig.blockSizeVertical * 2.5,),
                title: Text('World',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
                leading: Icon(TipyIcons.paper_plane, size: SizeConfig.blockSizeVertical * 3,),
                title: Text('Errands',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
                onTap: (){
                  Navigator.pushNamed(context, MyPostsScreen.id);

                },
                leading: Icon(TipyIcons.speech_bubble_1,  size: SizeConfig.blockSizeVertical * 2.5,),
                title: Text('My Posts',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
                onTap: (){
                  Navigator.pushNamed(context, MyRepliesScreen.id);
                },
                leading: Icon(TipyIcons.speech_bubble_3, size: SizeConfig.blockSizeVertical * 2.5,),
                title: Text('My Replies',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
                onTap: (){
                  setState(() {
                    if (isLight == true){
                      toggleIcon = Icon(TipyIcons.sun, size: SizeConfig.blockSizeVertical * 2.5,);
                      theme = TipyTheme.darkTheme;
                      col = Colors.white;
                      textFieldColor = Colors.grey[500];
                      sliderColor = Colors.grey[800];
                      isLight = false;
                      saveThemePref(false);


                    }
                    else{
                      toggleIcon = Icon(TipyIcons.crescent_moon, size: SizeConfig.blockSizeVertical * 2.5,);
                      theme = TipyTheme.lightTheme;
                      col = Colors.black;
                      textFieldColor = Colors.grey[200];
                      sliderColor = Colors.white;
                      isLight = true;
                      saveThemePref(true);

                    }
                  });
                },
                leading: toggleIcon,
              )
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Material(
            color: sliderColor,
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home, color: Colors.green),),
                Tab(icon: Icon(Icons.dashboard, color: Colors.grey),),
                Tab(icon: Icon(Icons.notifications, color: Colors.grey),),
              ],
            ),
          ),
        ),
        body: selectedScreen == Screen.map
        ? MapScreen(color: sliderColor, col: col, context: context)
        : ListScreen(),
      ),
    );
  }

  void mapCreated(controller){
    setState(() {
      _controller = controller;
    });
  }



}


Widget MapScreen({color, context, mapCreated, col}){
  return SlidingUpPanel(
    onPanelClosed: (){
      postController.clear();
    },
    color: color,
    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
    collapsed: Container(
      color: color,
      child: Center(
        child: Center(
            child: Column(
              children: <Widget>[
                Icon(Icons.keyboard_arrow_up, size: SizeConfig.blockSizeVertical * 3, color: Colors.grey,),
                Text(' Swipe up to post', style: TextStyle(fontFamily: 'myriadpro', fontSize: SizeConfig.blockSizeVertical * 2, color: Colors.grey),)
              ],
            )
        ),
      ),
    ),
    panel: Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.keyboard_arrow_down, size: SizeConfig.blockSizeVertical * 3, color: Colors.grey,),
                    Text('Pull down to dismiss', style: TextStyle(fontFamily: 'myriadpro', fontSize: SizeConfig.blockSizeVertical * 1.5, color: Colors.grey),)

                  ],
                ),
              ),

            ],
          ),
          Container(
            child: TextField(
              controller: postController,
              style: TextStyle(
                  fontFamily: 'myriadpro'
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: -10),
                  hintText: 'Say something...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontFamily: 'myriadpro'
                  )
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          GestureDetector(
          child: Container(
//            margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
            height: SizeConfig.blockSizeVertical * 5,
            width:  SizeConfig.blockSizeVertical * 13,
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(150)),
              color: Colors.green,
              shadowColor: Colors.greenAccent,
              elevation: 7,
              child: Center(
                child: Text(
                  'Post',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontFamily: 'myriadpro'
                  ),
                ),
              ),
            ),
          ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlacePicker.PlacePicker(
                      hintText: 'Search',
                      apiKey: 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48',   // Put YOUR OWN KEY here.
//                      onPlacePicked: (result) {
//                        print(result.vicinity);
//                        print(postController.text);
//
//                        _firestore.collection('posts').add({
//                          'text' : postText,
//                          'sender' : loggedInUser.email,
//                          'vicinity' : result.vicinity
//                        });
//
//                        Navigator.of(context).pop();
//                      },
                    selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused){
                        return isSearchBarFocused
                            ? Container()
                            : PlacePicker.FloatingCard(
                          bottomPosition: MediaQuery.of(context).size.height * 0.05 ,
                          leftPosition: MediaQuery.of(context).size.width * 0.3,
                          rightPosition: MediaQuery.of(context).size.width * 0.3,
                          width: SizeConfig.blockSizeHorizontal * 13,
                          height: SizeConfig.blockSizeVertical * 5,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                          child: state == PlacePicker.SearchingState.Searching ?
                          Center(child: CircularProgressIndicator(),) :
                              Container(
                                height: SizeConfig.blockSizeVertical * 5,
                                width: SizeConfig.blockSizeHorizontal * 13,
                                child: GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    width:  SizeConfig.blockSizeHorizontal * 13,
                                    child: Material(
                                      borderRadius: BorderRadius.all(Radius.circular(150)),
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          'Post Here',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig.blockSizeVertical * 2,
                                              fontFamily: 'myriadpro'
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    print(selectedPlace.vicinity);
                                    print(postController.text);
                                    getPostLatLong(
                                        'https://maps.googleapis.com/maps/api/place/details/json?place_id=${selectedPlace
                                            .placeId}&fields=geometry,name&key=AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48');





                                         Timer(Duration(seconds: 2), (){
                                           posts.push().set({
                                             'text': postController.text,
                                             'sender': loggedInUser.email,
                                             'vicinity': selectedPlace.vicinity,
                                             'UserID': userID,
                                             'g': postLong,
                                             'l': postLat,
                                             'radius': 0,
                                           'timestamp': '${DateTime.now().toUtc().millisecondsSinceEpoch}'
                                           }).then((_){
                                           scaffoldKey.currentState.showSnackBar(
                                           new SnackBar(duration: new Duration(seconds: 4), content:
                                           new Row(
                                           children: <Widget>[

                                           new Text("  Post is sent! 😌")
                                           ],
                                           ),
                                           ));
                                           });


                                          allPosts.push().set({
                                            'text': postController.text,
                                            'sender': loggedInUser.email,
                                            'vicinity': selectedPlace.vicinity,
                                            'UserID': userID,
                                            'g': postLong,
                                            'l': postLat,
                                            'radius': 0,
                                            'timestamp': '${DateTime.now().toUtc().millisecondsSinceEpoch}'
                                          });


                                           postController.clear();

                                         });



                                    Navigator.of(context).pop();
                                  }
                                ),
                              )
                        );
                    },
                      initialPosition: LatLng(latitude, longitude),
                      useCurrentLocation: true,
                      autocompleteLanguage: 'en',
                      region: 'gh',
                    ),
                  ),
                );

              })
        ],
      ),
    ),
    minHeight: SizeConfig.blockSizeVertical * 7.5,
    maxHeight: MediaQuery.of(context).size.height,
    body:  Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 17),
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 10),
            height: MediaQuery.of(context).size.height - 50,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(7.9465, -1.0232),
                zoom: 12.0,
              ),

              onMapCreated: (GoogleMapController controller){
                mapController = controller;
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget ListScreen(){
  return Container(
    child: Center(
      child: Text(
        'Screen'
      ),
    ),
  );
}



