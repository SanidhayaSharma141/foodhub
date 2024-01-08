// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:foodhub/model/fetch_data.dart';
import 'package:foodhub/model/restaurent.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderOrderScreen extends StatefulWidget {
  HeaderOrderScreen({super.key, required this.location});

  LocationData location;
  @override
  State<HeaderOrderScreen> createState() => _HeaderOrderScreenState();
}

class _HeaderOrderScreenState extends State<HeaderOrderScreen> {
  @override
  void initState() {
    super.initState();
    _fetchRestaurants();
    _getAddressFromLatLng();
    setState(() {});
  }

  ApiService _apiService = ApiService();
  String _currentAddress = "";
  Future<void> _getAddressFromLatLng() async {
    await placemarkFromCoordinates(
            widget.location.latitude!, widget.location.longitude!)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.locality},${place.name},${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  List<Restaurants> restList = [];
  Future<void> _fetchRestaurants() async {
    double userLat = widget.location.latitude!;
    double userLng = widget.location.longitude!;
    final result = await _apiService.getRestaurants(userLat, userLng);
    List<Restaurants> temp = [];
    print(result['data']);
    result['data'].forEach((value) {
      temp.add(Restaurants(
        discount: value['discount'].toDouble(),
        distance: value['distance'].toDouble(),
        imageUrl: value['primary_image'].toString(),
        rating: value['rating'].toDouble(), // Corrected toDouble()
        name: value['name'].toString(), // Corrected toString()
        tags: value['tags'].toString(),
      ));
    });
    setState(() {
      restList = temp;
      list = restList;
    });
  }

  List<Restaurants> list = [];
  TextEditingController searchName = TextEditingController();
  int selectedOption = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    void _filterRestaurantsByName(String restaurantName) {
      setState(() {
        if (restaurantName.isEmpty) {
          list = restList;
        } else {
          list = restList
              .where((restaurant) => restaurant.name
                  .toLowerCase()
                  .contains(restaurantName.toLowerCase()))
              .toList();
        }
      });
    }

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      width: width,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.pink[100]!.withOpacity(0.5),
        child: Column(
          children: [
            Text(_currentAddress.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return Text("hello bitch");
            //     },
            //     scrollDirection: Axis.horizontal,
            //   ),
            // )
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GNav(
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
                    controller: searchName,
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
                      hintText: "Search Food Restaurants",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _filterRestaurantsByName(searchName.text);
                  },
                )
              ],
            ),
            const Divider(),
            Text(
              "Nearby Restaurants(${list.length} )",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                      name: list[index].name,
                      rating: list[index].rating,
                      discount: list[index].discount,
                      imageUrl: list[index].imageUrl);
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GNav(
                onTabChange: (value) {},
                tabs: const [
                  GButton(
                      icon: FontAwesomeIcons.home,
                      gap: 5,
                      backgroundColor: Colors.white),
                  GButton(
                      icon: Icons.save,
                      gap: 5,
                      text: "Save",
                      backgroundColor: Colors.white),
                  GButton(
                      icon: FontAwesomeIcons.cartShopping,
                      text: "Your Cart",
                      gap: 5,
                      backgroundColor: Colors.white),
                  GButton(
                      icon: Icons.settings,
                      gap: 5,
                      text: "",
                      backgroundColor: Colors.white),
                  GButton(
                      icon: FontAwesomeIcons.qrcode,
                      text: "Scan",
                      gap: 5,
                      backgroundColor: Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
