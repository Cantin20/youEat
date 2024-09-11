import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youeat/common/app_style.dart';
import 'package:youeat/common/reusable_text.dart';
import 'package:youeat/constants/constants.dart';
import 'package:youeat/models/login_response.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key, this.user});
  final LoginResponse? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.06, // Increased height to better fit the trailing icon
      width: width,
      color: kLightWhite,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 16.w, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: const CircleAvatar(
                        backgroundColor: kGrayLight,
                        backgroundImage: AssetImage("assets/images/cantin.jpg"),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Padding(
                      padding: EdgeInsets.all(4.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: user!.username ?? "Username",
                            style: appStyle(14, kGray, FontWeight.bold),
                          ),
                          ReusableText(
                            text: user!.email ?? "Email",
                            style: appStyle(12, kGray, FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_note_outlined,
                    color: kPrimary,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        final TextEditingController usernameController =
                            TextEditingController(text: user!.username);
                        final TextEditingController emailController =
                            TextEditingController(text: user!.email);

                        return AlertDialog(
                          title: const Text('Edit User Information'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                ),
                              ),
                              TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle saving the updated user information
                                String newUsername = usernameController.text;
                                String newEmail = emailController.text;

                                // TODO: Update user information logic here

                                Navigator.of(context).pop();
                              },
                              child: const Text('Save'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
