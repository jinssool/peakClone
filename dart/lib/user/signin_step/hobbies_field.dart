import 'package:dart/profiles/constants/color_constants.dart';
import 'package:dart/user/common/const/color.dart';
import 'package:dart/user/common/const/hobbiesList.dart';
import 'package:dart/user/signin_step/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HobbiesField extends StatefulWidget {
  const HobbiesField({super.key});

  @override
  State<HobbiesField> createState() => _HobbiesFieldState();
}

class _HobbiesFieldState extends State<HobbiesField> {
  TextEditingController searchController = TextEditingController();
  List<String> selectedHobbies = [];
  List<String> _filteredHobbies = [];

  @override
  void initState() {
    super.initState();
  }

  void _filterHobbies(String query) {
    _filteredHobbies.clear();
    if (query.isEmpty) {
      setState(() {
        _filteredHobbies = [];
      });
    } else if (query.length >= 2) {
      allHobbies.forEach((hobby) {
        if (hobby.toLowerCase().contains(query.toLowerCase())) {
          _filteredHobbies.add(hobby);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = const TextStyle(
      color: Colors.black,
      // fontSize: isOnKeyBoard ? 45 : 30,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    );
    TextStyle titleStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 244, 253),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: FloatingActionButton.extended(
          onPressed: selectedHobbies.length >= 8
              ? () {
                  nextPage();
                }
              : null,
          backgroundColor: selectedHobbies.length >= 8
              ? Colors.purple[200]
              : Colors.grey[400],
          label: const Text("Continue"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What are your interests?",
              style: textstyle,
            ),
            const SizedBox(height: 10),
            const Text(
              "Select atleast 8 interests of yours.",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color.fromARGB(255, 86, 86, 86)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              child: TextField(
                controller: searchController,
                onChanged: _filterHobbies,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: .8),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            BorderSide(color: transPrimaryColor, width: 2.5)),
                    hintText: "Search for hobbies...",
                    hintStyle: const TextStyle(fontSize: 15),
                    suffix: IconButton(
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            _filteredHobbies = [];
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 22.5,
                        )),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 22.5,
                    )),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Wrap(
                  spacing: 5.0,
                  runSpacing: 1,
                  children: _filteredHobbies.map((hobby) {
                    return FilterChip(
                        selected: selectedHobbies.contains(hobby),
                        backgroundColor: Colors.grey[200],
                        selectedColor: Colors.purple[200],
                        label: Text(hobby),
                        onSelected: (bool selected) {
                          updateSelectedHobby(hobby);
                          print(selectedHobbies);
                        });
                  }).toList(),
                );
              },
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 5,
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: hobbiesCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(children: [
                        Text(hobbiesCategories[index].name, style: titleStyle),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 1,
                          children:
                              hobbiesCategories[index].hobbies.map((hobby) {
                            return FilterChip(
                                selected: selectedHobbies.contains(hobby),
                                backgroundColor: Colors.grey[300],
                                selectedColor: Colors.purple[200],
                                label: Text(hobby),
                                onSelected: (bool selected) {
                                  updateSelectedHobby(hobby);
                                  print(selectedHobbies);
                                });
                          }).toList(),
                        ),
                      ]),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedHobby(String hobby) {
    setState(() {
      if (selectedHobbies.contains(hobby)) {
        selectedHobbies.remove(hobby);
      } else {
        selectedHobbies.add(hobby);
      }
    });
  }

  void nextPage() {
    Get.to(const PasswordField());
  }
}
