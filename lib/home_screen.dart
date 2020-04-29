

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:login_app4/size_config.dart';
import 'package:login_app4/tipy_icons_icons.dart';
import 'package:login_app4/tipy_theme.dart';
import 'location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:place_picker/place_picker.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tuple/tuple.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart' as Loc;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';





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


  ProgressDialog pr;

  double latitude;
  double longitude;

  void getLocation() async{
    Locations location = Locations();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
  }



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

  TabController tabController;

  TextEditingController controller = TextEditingController();

  Icon toggleIcon = Icon(TipyIcons.crescent_moon, size: SizeConfig.blockSizeVertical * 2.5,);
  var theme = TipyTheme.lightTheme;
  Color col = Colors.black;
  Color textFieldColor = Colors.grey[200];
  bool isLight = true;
  Color sliderColor = Colors.white;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    getCurrentUser();
    getLocation();


  }

  @override
  Widget build(BuildContext context) {

    pr = new ProgressDialog(context);




    return MaterialApp(
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            height: SizeConfig.blockSizeVertical * 5,
            child: GooglePlaceAutoCompleteTextField(
              textStyle: TextStyle(
                fontFamily: 'myriadpro'
              ),
              textEditingController: controller,
              googleAPIKey: 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48',
              debounceTime: 60,
              inputDecoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(150)),
                    borderSide: BorderSide(color: textFieldColor)
                  ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontFamily: 'myriadpro',
                  color: col,
                ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.all(Radius.circular(150))
                  ),
                filled: true,
                fillColor: textFieldColor,
              ),
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
            }),
          ],

          elevation: 5,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  accountName: Text('User One'),
                  accountEmail: Text('lmao@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('images/logo.png'),
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
                leading: Icon(TipyIcons.speech_bubble_1,  size: SizeConfig.blockSizeVertical * 2.5,),
                title: Text('My My Posts',
                  style: TextStyle(
                      fontFamily: 'myriadpro',
                      fontSize: SizeConfig.blockSizeVertical * 2
                  ),
                ),
              ),
              ListTile(
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
                    }
                    else{
                      toggleIcon = Icon(TipyIcons.crescent_moon, size: SizeConfig.blockSizeVertical * 2.5,);
                      theme = TipyTheme.lightTheme;
                      col = Colors.black;
                      textFieldColor = Colors.grey[200];
                      sliderColor = Colors.white;
                      isLight = true;
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
        body: SlidingUpPanel(
          color: sliderColor,
          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 4, right: SizeConfig.blockSizeHorizontal * 4),
          collapsed: Container(
            color: sliderColor,
            child: Center(
              child: Center(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up, size: SizeConfig.blockSizeVertical * 3, color: col,),
                      Text(' Swipe up to post', style: TextStyle(fontFamily: 'myriadpro', fontSize: SizeConfig.blockSizeVertical * 2, color: col),)
                    ],
                  )
              ),
            ),
          ),
          panel: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: SizeConfig.blockSizeHorizontal *13,),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.keyboard_arrow_down, size: SizeConfig.blockSizeVertical * 3, color: Colors.grey,),
                            Text('Pull down to dismiss', style: TextStyle(fontFamily: 'myriadpro', fontSize: SizeConfig.blockSizeVertical * 1.5, color: Colors.grey),)

                          ],
                        ),
                      ),
                    ),
                    IconButton(icon: Icon(Icons.location_on, size: 30, color: Colors.green,), onPressed: () async{
                      Loc.LocationResult  result = await showLocationPicker(context, 'AIzaSyDRttc2Q3q2aEzY-ke41sbgABJ9YMr0r48', initialCenter: LatLng(31.1975844, 29.9598339));
                    })
                  ],
                ),
                Container(
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'myriadpro'
                    ),
                    decoration: InputDecoration(
                      hintText: 'Say something...',
                      hintStyle: TextStyle(
                        fontFamily: 'myriadpro'
                      )
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                )
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
                      zoom: 6.0,
                    ),
                    onMapCreated: mapCreated,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void mapCreated(controller){
    setState(() {
      _controller = controller;
    });
  }



}


