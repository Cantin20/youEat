// ignore_for_file: prefer_collection_literals

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/controllers/user_location_controller.dart';
import 'package:http/http.dart' as http;
import 'package:youeat/models/address_model.dart';
import 'package:youeat/views/login/email_textfield.dart';
import 'package:youeat/views/profile/address_page.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({super.key});

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  late final PageController _pageController = PageController(initialPage: 0);
  GoogleMapController? _mapController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();
  final TextEditingController _instructions = TextEditingController();
  LatLng? _selectedPosition;
  List<dynamic> _placeList = [];
  List<dynamic> _selectedPlace = [];

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String searchQuery) async {
    if (searchQuery.isNotEmpty) {
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchQuery&key=$API_KEY');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.statusCode);
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      }
    } else {
      _placeList = [];
    }
  }

  void _getPlaceDetails(String placeId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$API_KEY');
    final response = await http.get(url).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      final location = json.decode(response.body);

      final lat = location['results']['geometry']['location']['lat'] as double;
      final lng = location['results']['geometry']['location']['lng'] as double;

      final address = location['results']['formatted_address'];

      String postalCode = '';

      final addressComponents = location['results']['address_components'];

      for (var components in addressComponents) {
        if (components['types'].contains('postal_code')) {
          postalCode = components['long_name'];
          break;
        }
      }

      setState(() {
        _selectedPosition = LatLng(lat, lng);
        _searchController.text = address;
        _postalCode.text = postalCode;
        moveToSelectedPosition();
        _placeList = [];
      });
    }
  }

  void moveToSelectedPosition() {
    if (_selectedPosition != null && _mapController != null) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _selectedPosition!, zoom: 15)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationController = Get.put(UserLocationController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kOffWhite,
          elevation: 0,
          title: const Text('Shipping Address'),
          leading: Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 0),
              child: locationController.tabIndex == 0
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        AntDesign.closecircleo,
                        color: kPrimary,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        locationController.setTabIndex = 0;
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(
                        AntDesign.leftcircleo,
                        color: kDark,
                      ),
                    ),
            ),
          ),
          actions: [
            Obx(() => locationController.tabIndex == 1
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: IconButton(
                        onPressed: () {
                          locationController.setTabIndex = 1;
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        icon: const Icon(
                          AntDesign.rightcircleo,
                          color: kDark,
                        )),
                  ))
          ],
        ),
        body: SizedBox(
          height: height,
          width: width,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            onPageChanged: (index) {
              _pageController.jumpToPage(index);
            },
            children: [
              Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                        target: _selectedPosition ??
                            const LatLng(
                                3.8132776520957274, 11.557988810807808),
                        zoom: 15),
                    markers: _selectedPosition == null
                        ? Set.of([
                            Marker(
                                markerId: const MarkerId('Your Location'),
                                position: const LatLng(
                                    3.8132776520957274, 11.557988810807808),
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  locationController.getUserAddress(position);
                                  setState(() {
                                    _selectedPosition = position;
                                  });
                                }),
                          ])
                        : Set.of([
                            Marker(
                                markerId: const MarkerId('Your Location'),
                                position: _selectedPosition!,
                                draggable: true,
                                onDragEnd: (LatLng position) {
                                  locationController.getUserAddress(position);
                                  setState(() {
                                    _selectedPosition = position;
                                  });
                                }),
                          ]),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        color: kOffWhite,
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                              hintText: "Search for your address ..."),
                        ),
                      ),
                      _placeList.isEmpty
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: ListView(
                              children:
                                  List.generate(_placeList.length, (index) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      _placeList[index]['description'],
                                      //style: appStyle(14, kGrayLight, FontWeight.w400),
                                    ),
                                    onTap: () {
                                      _getPlaceDetails(
                                          _placeList[index]['place_id']);
                                      _selectedPlace.add(_placeList[index]);
                                    },
                                  ),
                                );
                              }),
                            ))
                    ],
                  )
                ],
              ),
              BackGroundContainer(
                color: kOffWhite,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    EmailTextField(
                      controller: _searchController,
                      hintText: "Address",
                      prefixIcon: const Icon(Ionicons.location_sharp),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    EmailTextField(
                      controller: _postalCode,
                      hintText: "Postal Code",
                      prefixIcon: const Icon(Ionicons.location_sharp),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    EmailTextField(
                      controller: _instructions,
                      hintText: "Delivery Instruction",
                      prefixIcon: const Icon(Ionicons.add_circle_outline),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                              text: "Set address as default",
                              style: appStyle(12, kDark, FontWeight.w600)),
                          Obx(() => CupertinoSwitch(
                              thumbColor: kSecondary,
                              trackColor: kPrimary,
                              value: locationController.isDefault,
                              onChanged: (value) {
                                locationController.setIsDefault = value;
                              }))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButtom(
                      onTap: () {
                        if (_searchController.text.isNotEmpty &&
                            _postalCode.text.isNotEmpty &&
                            _instructions.text.isNotEmpty) {
                          AddressModel model = AddressModel(
                              addressLine1: _searchController.text,
                              postalCode: _postalCode.text,
                              addressModelDefault: locationController.isDefault,
                              longitude: _selectedPosition!.longitude,
                              latitude: _selectedPosition!.latitude,
                              deliveryInstructions: _instructions.text);

                          String data = addressModelToJson(model);
                          
                        }
                      },
                      btnHeigth: 40,
                      text: " S U B M I T",
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
