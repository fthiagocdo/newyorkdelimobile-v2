import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/get_keep_logged.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<Map> getMenu() async {
    bool getUser = await getKeepLogged();
    if (getUser == true) {
      User? user = await initializeFirebaseLogin();
      if (user != null) {
        return {
          "name": user.displayName.toString() != "null"
              ? user.displayName.toString()
              : "User",
          "email": user.email ?? "",
          "photoURL": user.photoURL ?? ""
        };
      }
      return {"data": false};
    } else {
      return {"data": false};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, dynamic>>(
      future: getMenu(),
      builder: (context, snapshot) {
        // print(snapshot.data!["data"]);
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data!["data"] == false) {
            
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 80.0,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Color(0xFF4f4d1f),
                        Colors.lightGreen,
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          "New York Deli",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.menu,
                    color: Color(0xFF4f4d1f),
                  ),
                  title: const Text(
                    'Menu',
                    style: TextStyle(color: Color(0xFF4f4d1f)),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xFF4f4d1f)),
                  title: const Text('Home',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Color(0xFF4f4d1f)),
                  title: const Text('Contact Us',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {
                    Modular.to.pushNamed("/Contact-me");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.login, color: Color(0xFF4f4d1f)),
                  title: const Text('Login',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {
                    Modular.to.pushNamed("/Login");
                  },
                ),
              ],
            ),
          );
        } else {
          // ignore: prefer_typing_uninitialized_variables
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 235.0,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Color(0xFF4f4d1f),
                        Colors.lightGreen,
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if ( snapshot.data?["photoURL"] != null && snapshot.data?["photoURL"] != "" ) CircleAvatar(
                                radius: 55.0,
                                foregroundImage:
                                    NetworkImage(snapshot.data?["photoURL"] ?? ""),
                              ) else const CircleAvatar(
                                radius: 55.0,
                                foregroundImage:
                                    AssetImage("assets/images/user.png"),
                              ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        snapshot.data?["name"] == ""
                            ? Text(
                                snapshot.data!["email"],
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data?["name"] ?? "",
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot.data?["email"] ?? "",
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Color(0xFF4f4d1f),
                  ),
                  title: const Text(
                    'Profile',
                    style: TextStyle(color: Color(0xFF4f4d1f)),
                  ),
                  onTap: () {
                    Modular.to.pushNamed("/Profile");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Color(0xFF4f4d1f)),
                  title: const Text('Home',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Color(0xFF4f4d1f)),
                  title: const Text('Contact Us',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {
                    Modular.to.pushNamed("/Contact-me");
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.list_alt_outlined,
                      color: Color(0xFF4f4d1f)),
                  title: const Text('Order History',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.shopping_cart_outlined,
                      color: Color(0xFF4f4d1f)),
                  title: const Text('Checkout',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Color(0xFF4f4d1f)),
                  title: const Text('Log out',
                      style: TextStyle(color: Color(0xFF4f4d1f))),
                  onTap: () async {
                    await signOut();
                    setState(() {});
                    // Modular.to.navigate("/Login");
                    Navigator.pushNamedAndRemoveUntil(context, '/Login', ModalRoute.withName('/Login'));

                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
