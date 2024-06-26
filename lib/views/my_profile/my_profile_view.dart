import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trinity_wizard/services/storage/dto/user_dto.dart';
import 'package:trinity_wizard/theme/app_colors.dart';
import 'package:trinity_wizard/views/my_profile/my_profile_view_model.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({
    super.key,
  });

  @override
  _MyProfileViewState createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  final MyProfileViewModel vm = Get.find<MyProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: vm.logout,
            child: const Text(
              'Logout',
            ),
          ),
        ],
      ),
      body: Obx(() {
        final UserDto? contact = vm.contact.value;
        if (contact == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: <Widget>[
            SizedBox.square(
              dimension: 100,
              child: DecoratedBox(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Color(0xff0077b6),
                ),
                child: Center(
                  child: Text(
                    (contact.firstName[0] + contact.lastName[0]).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${contact.firstName} ${contact.lastName}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (contact.email != null) ...<Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                '${contact.email}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
            if (contact.dob != null) ...<Widget>[
              const SizedBox(
                height: 10,
              ),
              Text(
                '${contact.dob}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 53,
              child: TextButton(
                onPressed: vm.editProfile,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0x1A96D3F2),
                  foregroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Update my detail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
