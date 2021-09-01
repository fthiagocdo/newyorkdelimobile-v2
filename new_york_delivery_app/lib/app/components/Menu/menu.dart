import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Row(
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
            leading: const Icon(Icons.menu,color: Color(0xFF4f4d1f),),
            title: const Text('Menu', style: TextStyle(color: Color(0xFF4f4d1f)),),
            onTap: (){},
          ),
           ListTile(
            leading: const Icon(Icons.home, color: Color(0xFF4f4d1f)),
            title: const Text('Home', style: TextStyle(color: Color(0xFF4f4d1f))),
            onTap: (){},
          ),
           ListTile(
            leading:  const Icon(Icons.email, color: Color(0xFF4f4d1f)),
            title:  const Text('Contact Us', style: TextStyle(color: Color(0xFF4f4d1f))),
            onTap: (){},
          ),
           ListTile(
            leading:  const Icon(Icons.login, color: Color(0xFF4f4d1f)),
            title:  const Text('Login', style: TextStyle(color: Color(0xFF4f4d1f))),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
