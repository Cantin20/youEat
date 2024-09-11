import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:youeat/controllers/user_location_controller.dart';
import 'package:youeat/models/hook_models/fetch_default_address.dart';

class CustomAppBar extends StatefulHookWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final controller = Get.put(UserLocationController());
  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    
    final hookResults = useFetchDefault();
    final addresses = hookResults.data;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                    radius: 22.r,
                    backgroundColor: kSecondary,
                    backgroundImage:
                        const AssetImage('assets/images/cantin.jpg')),
                Padding(
                  padding: EdgeInsets.only(bottom: 6.h, left: 8.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: 'Deliver To',
                          style: appStyle(13, kSecondary, FontWeight.w600)),
                      Obx(
                        () => SizedBox(
                          width: width * 0.65,
                          child: Text(
                              controller.address == ""
                                  ? "IAI CAMEROON, Awae"
                                  : controller.address,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  appStyle(11, kGrayLight, FontWeight.normal)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(
              getTimeOfDay(),
              style: const TextStyle(fontSize: 35),
            )
          ],
        ),
      ),
    );
  }

  String getTimeOfDay() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return ' ☀️';
    } else if (hour >= 12 && hour < 16) {
      return '⛅';
    } else {
      return '🌙';
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    LatLng currentLocation = const LatLng(3.8132776520957274, 11.557988810807808);
    print(currentLocation);
    controller.setPosition(currentLocation);

    controller.getUserAddress(currentLocation);
  }
}
