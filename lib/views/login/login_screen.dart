import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlivequery/views/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Please Login",
                  style: TextStyle(fontSize: 34),
                ),
                CupertinoButton.filled(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(CupertinoIcons.person, color: Colors.white),
                      Text(
                        "Admin",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => const HomeScreen(isAdmin: true)));
                  },
                ),
                CupertinoButton.filled(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        CupertinoIcons.person_2,
                        color: Colors.white,
                      ),
                      Text(
                        "Customer",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) =>
                            const HomeScreen(isAdmin: false)));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*





 */