import 'package:dart/profiles/custom_widgets/random_color_generator.dart';
import 'package:dart/profiles/custom_widgets/user_info.dart';
import 'package:flutter/material.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({
    super.key,
  });

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  String userImage =
      "https://cdn.pixabay.com/photo/2018/11/01/08/58/object-3787552_1280.jpg";
  String nickName = "";
  String userName = "";
  int age = 0;

  String dob = "";
  String userBio =
      "🌍 Exploring the world one tweet at a time | 📚 Lifelong learner | 🎵 Music enthusiast | ☕ Coffee lover | 🚀 Let's connect and share stories! #AdventureAwaits";
  Color primaryColor = const Color.fromARGB(255, 81, 255, 200);
  List<String> interests = ["Programming", "Eating", "Reading", "Exploring"];

// /*-------------Load user's data either from client cache or server-----------------*/
//   Future<void> loadUserData() async {
//     setState(() {
//       nickName = nickName;

//       age = int.parse(loggedUser.dob);
//       gender = 0; // need to add gender in server first
//       dob = loggedUser.dob;
//       userBio = loggedUser.bio;
//       interests = loggedUser.hobbies;
//     });
//   }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? personalInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (personalInfo == null) {
      print(
          '=========================error=========================== on getting argument from explore screen');
    }
    /*-------------------------- UI Start ---------------------------------------- */
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                "Peak",
                style: TextStyle(
                    color: Color.fromARGB(255, 81, 54, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Tew",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 400,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(userImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                //Adds black gradient from bottom to top to image
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  children: [
                    UserInfoDisplay(
                      name: personalInfo?['nickname'],
                      age: "${birthdayIntoAge(personalInfo?['birthday'])} yo",
                      userBio: userBio,
                      interests: interests,
                      personalPrimaryColor: generateRandomLightColor(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int birthdayIntoAge(String dob) {
  DateTime now = DateTime.now(); // Method to get current date
  int currentYear = now.year;
  return (currentYear - int.parse(dob.split("-")[0]));
}
