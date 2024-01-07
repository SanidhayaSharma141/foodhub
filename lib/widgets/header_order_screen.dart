import 'package:flutter/material.dart';
import 'package:foodhub/model/fetch_data.dart';
import 'package:foodhub/model/restaurent.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderOrderScreen extends StatefulWidget {
  const HeaderOrderScreen({super.key});

  @override
  State<HeaderOrderScreen> createState() => _HeaderOrderScreenState();
}

class _HeaderOrderScreenState extends State<HeaderOrderScreen> {
  ApiService _apiService = ApiService();
  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
  }

  List<Restaurants> restList = [];
  Future<void> _fetchRestaurants() async {
    try {
      // Replace with the actual user's location coordinates
      double userLat = 25.22;
      double userLng = 45.32;

      final result = await _apiService.getRestaurants(userLat, userLng);

      setState(() {
        result['data'].forEach((value) {
          restList.add(Restaurants(
              discount: value['discount'],
              distance: value['distance'],
              imageUrl: value['primary_image'],
              id: value['id'],
              name: value['name'],
              tags: value['tags']));
        });
      });
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  final selectOptions = ["all", "pizza"];
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.pink[100]!.withOpacity(0.5),
            child: Column(
              children: [
                Text("Location"),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Text("hello bitch");
                //     },
                //     scrollDirection: Axis.horizontal,
                //   ),
                // )
                GNav(
                  onTabChange: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                  tabs: [
                    GButton(
                        icon: FontAwesomeIcons.check,
                        text: "All",
                        backgroundColor: selectedOption == 0
                            ? Colors.red.withOpacity(0.5)
                            : Colors.white),
                    GButton(
                        icon: Icons.local_pizza,
                        text: "Pizza",
                        backgroundColor: selectedOption == 1
                            ? Colors.red.withOpacity(0.5)
                            : Colors.white),
                    GButton(
                        icon: FontAwesomeIcons.burger,
                        text: "Burger",
                        backgroundColor: selectedOption == 2
                            ? Colors.red.withOpacity(0.3)
                            : Colors.white),
                    GButton(
                        icon: FontAwesomeIcons.leaf,
                        text: "Veg",
                        backgroundColor: selectedOption == 3
                            ? Colors.red.withOpacity(0.5)
                            : Colors.white),
                    GButton(
                        icon: FontAwesomeIcons.bowlFood,
                        text: "Veg",
                        backgroundColor: selectedOption == 4
                            ? Colors.red.withOpacity(0.5)
                            : Colors.white)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: GlobalKey(),
                        maxLines: 2,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () async {},
                            icon: const Icon(Icons.search),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search Food Items",
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: restList.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                    name: restList[index].name,
                    discount: restList[index].discount,
                    imageUrl: restList[index].imageUrl);
              },
            ),
          ),
        ],
      ),
    );
  }
}
