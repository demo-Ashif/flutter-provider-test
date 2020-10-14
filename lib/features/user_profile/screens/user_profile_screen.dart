import 'package:flutter/material.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/utils/screen_aware_size.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/core/view_models/user_profile_viewmodel.dart';
import 'package:footsapp/features/user_profile/widgets/profile_card.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _sharePrefUtil = sl<SharedPrefUtil>();
  ScreenAwareSize sw;

  @override
  void initState() {
    super.initState();
    sw = ScreenAwareSize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<UserProfileViewModel>(
        builder: (ctx, viewmodel, child) {
          print('In profile: ${viewmodel.userProfile.toString()}');
          return Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(height: 40),
              ),
              Flexible(
                flex: 8,
                child: ProfileCardWidget(
                  profile: viewmodel.userProfile,
                  onEditButtonClick: () async {
                    await Navigator.pushNamed(ctx, EditProfileScreen.SCREEN_ID);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          );
        },
      ),
    );
  }
}
