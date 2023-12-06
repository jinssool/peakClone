import 'dart:async';
import 'package:dart/common/api/route_address.dart';
import 'package:dart/common/api/token_request.dart';
import 'package:dart/common/local_storage/const.dart';
import 'package:dart/explore_screen/common/dummy_users.dart';
import 'package:dart/profiles/constants/color_constants.dart';
import 'package:dart/profiles/screens/other_person_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:background_location/background_location.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  _ExploreScreenState();
  Position? currentPosition;
  String yourLocation = "";
  int distance = 0;
  Map<String, dynamic>? otherUserProfile;
  late Timer timer;
  List<DummyUsers> usersDataWithinRadius = [];
// gps

  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';
  static const LONGITUDE = 'longitude';
  static const LATITUDE = 'latitude';
  @override
  void initState() {
    gpsService();
    _initLocation();
    setBakcground();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    //_stopLocationTracking();
  }

/* ----------------------------- about gps service ----------------------------- */
//get permission for gps service and get location.

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openAppSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double calculateDistance(Position? userLocation, dynamic nextUserLocation) {
    print(nextUserLocation);
    print(nextUserLocation);

    print(nextUserLocation);

    print(nextUserLocation);

    return Geolocator.distanceBetween(
      userLocation!.latitude,
      userLocation.longitude,
      double.parse(nextUserLocation[LATITUDE]),
      double.parse(nextUserLocation[LONGITUDE]),
    );
  }

//================= Function to get get user within radius =====================
  void getUsersWithinRadius() {
    print(otherUsersData);
    setState(() {
      usersDataWithinRadius = otherUsersData
          .where((user) =>
              calculateDistance(currentPosition, user.location).toInt() <= 100)
          .toList();
    });

    print("Number of users within radius: ${usersDataWithinRadius.length}");
  }

//================= api service with server ( GPS INFO ) =====================

  Future<void> sendUserGPS(double x, double y) async {
    try {
      final sendGPS = ApiService();
      final accessToken = await storage.read(key: accessTokenKeyLS);
      final gpsResponse = await sendGPS.postWithToken(
        accessToken: accessToken!,
        toUrl: gpsURL,
        data: {
          LATITUDE: x,
          LONGITUDE: y,
        },
      );

      final message = await sendGPS.tokenReponseCheck(gpsResponse);
      print(gpsResponse!.data);
      print(gpsResponse.data['users'][0]['longtitude'].toString());

      print(gpsResponse.data['users'][0]['longtitude'].toString());

      print(gpsResponse.data['users'][0]['longtitude'].toString());
      if (message == 'success') {
        for (var i = 0; i < gpsResponse.data['users'].length; i++) {
          DummyUsers personInRadius = DummyUsers(
            name: gpsResponse.data['users'][i]['nickname'],
            location: {
              LONGITUDE: gpsResponse.data['users'][i][LONGITUDE].toString(),
              LATITUDE: gpsResponse.data['users'][i][LATITUDE].toString()
            },
            userImage:
                "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=987&q=80",
          );
          otherUsersData[i] = personInRadius;
        }
        print("successfully sending user's GPS to the server");
      } else {
        print(
            "=================== there is an error on sending GPS INFO to the server");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

// -------------------------- for background ------------------------------

  void setBakcground() async {
    print("=====setback called== 1===");
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    print("=====setback called== 2===");
    //await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService();
    print("=====setback called== 3===");
    BackgroundLocation.getLocationUpdates((location) {
      setState(() {
        latitude = location.latitude.toString();
        longitude = location.longitude.toString();
        accuracy = location.accuracy.toString();
        altitude = location.altitude.toString();
        bearing = location.bearing.toString();
        speed = location.speed.toString();
        time = DateTime.fromMillisecondsSinceEpoch(location.time!.toInt())
            .toString();

        print('''\n
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
                        Speed: $speed
                        Time: $time
                      ''');
      });
      print("=====setback called== 3===");
    });
  }

//=============== To get data of users only within the radius of 100m ==================

  Future<List<DummyUsers?>> replaceWithValidInfo() async {
    final getProfile = ApiService();
    final accessToken = await storage.read(key: accessTokenKeyLS);

    if (accessToken != null) {
      final profileResponse =
          await getProfile.requestWithToken(accessToken, otherProfileURL);
      final message = await getProfile.tokenReponseCheck(profileResponse);

      if (message == 'success') {
        otherUserProfile = profileResponse!.data;

        print("=========================${otherUserProfile!['users']!.length}");
        if (otherUserProfile != null) {
          // for (var i = 0; i < otherUserProfile!['users']!.length; i++) {
          //   getUsersWithinRadius();
          //   usersDataWithinRadius[i].name =
          //       otherUserProfile!['users'][i]['nickname'];

          //   print(otherUserProfile!['users'][i]['nickname']);
          //   print(usersDataWithinRadius[i].name);
          // }

          for (var i = 0; i < usersDataWithinRadius.length; i++) {
            usersDataWithinRadius[i].name =
                otherUserProfile!['users'][i]['nickname'];
            // print(otherUserProfile!['users'][i]['nickname']);
            print(usersDataWithinRadius[i].name);
            // print(otherUsersData[i].name);
            // print(otherUsersData[i].name);
          }

          return usersDataWithinRadius;
        }
      } else {
        usersDataWithinRadius = otherUsersData;
        print(
            "=================== there is an error on sending userinfo from the server");
      }
    } else {
      print(
          "================= error from reading accessToken from local Storage");
    }

    return usersDataWithinRadius;
  }

  Future _initLocation() async {
    Position position = await _determinePosition();
    if (mounted) {
      setState(() {
        currentPosition = position;
      });
    }
  }

  void gpsService() {
    const period = Duration(seconds: 15);
    timer = Timer.periodic(period, (timer) async {
      try {
        final position = await _determinePosition();
        final difference = Geolocator.distanceBetween(currentPosition!.latitude,
            currentPosition!.longitude, position.latitude, position.longitude);
        sendUserGPS(currentPosition!.latitude, currentPosition!.longitude);
        if (difference > 30) {
          setState(() {
            currentPosition = position;
          });
          sendUserGPS(currentPosition!.latitude, currentPosition!.longitude);
        }
      } catch (e) {}
    });
  }

  void getCurrentLocation() async {
    await BackgroundLocation().getCurrentLocation().then((location) {
      print('This is current Location ${location.toMap()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(children: [
            const SizedBox(height: 20),
            const Text(
              "Discover & Meet new people.",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                  onPressed: () async {
                    BackgroundLocation.getLocationUpdates((location) {
                      setState(() {
                        latitude = location.latitude.toString();
                        longitude = location.longitude.toString();
                        accuracy = location.accuracy.toString();
                        altitude = location.altitude.toString();
                        bearing = location.bearing.toString();
                        speed = location.speed.toString();
                        time = DateTime.fromMillisecondsSinceEpoch(
                                location.time!.toInt())
                            .toString();

                        print('''\n
                        Latitude:  $latitude
                        Longitude: $longitude
                        Altitude: $altitude
                        Accuracy: $accuracy
                        Bearing:  $bearing
                        Speed: $speed
                        Time: $time
                      ''');
                      });
                    });

                    getCurrentLocation();
                    currentPosition = await _determinePosition();
                    if (mounted) {
                      setState(() {
                        yourLocation =
                            "Latitude: ${currentPosition!.latitude}  Longitude: ${currentPosition!.longitude}";
                      });
                    }
                  },
                  child: const Text(
                    "Get your location",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(height: 20),
            Text(yourLocation.isNotEmpty
                ? yourLocation
                : 'Location not available'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton.icon(
                  onPressed: () {
                    getUsersWithinRadius();
                  },
                  icon: const Icon(
                    Icons.radar_outlined,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Search for people nearby",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<DummyUsers?>>(
                future: replaceWithValidInfo(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: otherUserProfile!['users'].length,
                      itemCount: usersDataWithinRadius.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DisplayOtherUsersInfo(
                          onTap: () {
                            Get.to(const OtherUserProfileScreen(),
                                arguments: otherUserProfile!['users'][index]);
                          },
                          name: usersDataWithinRadius[index].name,
                          userImage: usersDataWithinRadius[index].userImage,
                          distance: currentPosition?.latitude != null &&
                                  currentPosition?.longitude != null
                              ? calculateDistance(
                                  currentPosition,
                                  usersDataWithinRadius[index].location,
                                ).toInt()
                              : 0,
                        );
                      },
                    );
                  }
                }),
            const SizedBox(height: 15),
            const Text(
              'The people are shown when they are within 100m radius nearby you',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            )
          ]),
        ),
      ),
    );
  }
}

class DisplayOtherUsersInfo extends StatelessWidget {
  final String name;
  final String userImage;
  final int distance;
  final VoidCallback onTap;
  // final int timeInFoot;

  const DisplayOtherUsersInfo({
    super.key,
    required this.name,
    required this.userImage,
    required this.distance,
    required this.onTap,
    // required this.timeInFoot,
  });

  @override
  Widget build(BuildContext context) {
    int distanceBetween = distance;

    String calculateTimeInFoot() {
      int time = (distanceBetween ~/ 2);
      if (time < 60) {
        return "$time s";
      } else if (time < 3600) {
        return "${time ~/ 60} min";
      } else {
        return "${(time / 3600).toStringAsFixed(1)} hr";
      }
    }

    String calculateDistanceBetween() {
      if (distanceBetween < 1000) {
        return "$distanceBetween m";
      } else {
        return "${(distanceBetween / 1000).toStringAsFixed(1)} km";
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        userImage,
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(width: 15),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  calculateDistanceBetween(),
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  calculateTimeInFoot(),
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
