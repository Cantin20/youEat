import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/back_ground_container.dart';
import 'package:youeat/common/custom_buttom.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/common/shimmers/foodlist_shimmer.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/address_response.dart';
import 'package:youeat/models/hook_models/fetch_address.dart';
import 'package:youeat/views/home/widgets/address_list.dart';
import 'package:youeat/views/profile/shipping_address.dart';

class AddressPage extends HookWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = fetchAddresses();

    final List<AddressResponse> addresses = hookResults.data ?? [];
    final isLoading = hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
          title: ReusableText(
        text: "Addresses",
        style: appStyle(13, kGray, FontWeight.w600),
      )),
      body: BackGroundContainer(
        color: kOffWhite,
        child: Stack(
          children: [
            isLoading
                ? const FoodsListShimmer()
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: AddressListWidget(address: addresses),
                ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 30.h),
                child: CustomButtom(
                  onTap: () {
                    Get.to(() => const ShippingAddress());
                  },
                  text: "Add Address",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
