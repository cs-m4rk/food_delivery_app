import 'package:flutter/material.dart';
import 'package:food_delivery_app/themes/app_colors.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
            icon: Icon(LineAwesomeIcons.angle_left_solid),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('Edit Profile', style:TextStyle(color: AppColors.kWhiteColor),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Stack(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRect(
                  child: Image.asset('assets/images/profile.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.kPrimary.withOpacity(0.3),
                  ),
                  child: IconButton(
                      icon: const Icon(
                        LineAwesomeIcons.pencil_alt_solid,
                      ),
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: () {}),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(LineAwesomeIcons.user),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(LineAwesomeIcons.envelope),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icon(LineAwesomeIcons.phone_alt_solid),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Please Confirm'),
                            content: const Text('Edit Details ?'),
                            actions: [
                              // The "Yes" button
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Yes')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'))
                            ],
                          );
                        });
                  },
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: AppColors.kBlackColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kPrimary,
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                ),
              )
            ],
          )),
        ]),
      ),
    );
  }
}
