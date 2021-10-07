import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login_demo/user_model.dart';

class LoginController extends ChangeNotifier {
  UserDetails? userDetails;

  allowUserToSignInWithFB() async {
    var result = await FacebookAuth.i.login(
      permissions: ['public_profile', 'email'],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: 'email, name, picture.type(large)',
      );

      userDetails = UserDetails(
          displayName: requestData['name'],
          email: requestData['email'],
          photoURL: requestData['picture']['data']['url'] ?? " ");

      notifyListeners();
    }
  }

  allowUserToSignOut() async {
    await FacebookAuth.i.logOut();
    userDetails = null;
    notifyListeners();
  }
}
