import 'package:flutter/material.dart';
import 'package:flutter_facebook_login_demo/login_controller.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: loginPageUI(),
    );
  }

  loginPageUI() {
    return Consumer<LoginController>(builder: (context, model, child) {
      if (model.userDetails != null) {
        return alreadyLoggedInScreen(model);
      } else {
        return notLoggedInScreen(model);
      }
    });
  }

  alreadyLoggedInScreen(LoginController model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "User is Logged In",
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 100,
            backgroundImage: Image.network(model.userDetails!.photoURL!).image,
          ),
          const SizedBox(height: 20),
          Text(
            model.userDetails!.displayName!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            model.userDetails!.email!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            child: const Text("Logout"),
            onPressed: () {
              model.allowUserToSignOut();
            },
          )
        ],
      ),
    );
  }

  notLoggedInScreen(LoginController model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login Via Facebook",
            style: TextStyle(color: Colors.amber, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Image.asset('assets/facebook.png'),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              model.allowUserToSignInWithFB();
            },
            child: Image.asset(
              'assets/fb.png',
              width: 240,
            ),
          )
        ],
      ),
    );
  }
}
