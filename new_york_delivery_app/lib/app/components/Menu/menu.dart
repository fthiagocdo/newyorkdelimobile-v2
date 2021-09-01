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
                  Colors.green,
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
            leading: Icon(Icons.menu,color: Colors.lightGreen[900],),
            title:  Text('Menu', style: TextStyle(color: Colors.lightGreen[900]),),
            onTap: (){},
          ),
           ListTile(
            leading: Icon(Icons.home, color: Colors.lightGreen[900]),
            title:  Text('Home', style: TextStyle(color: Colors.lightGreen[900])),
            onTap: (){},
          ),
           ListTile(
            leading:  Icon(Icons.email, color: Colors.lightGreen[900]),
            title:  Text('Contact Us', style: TextStyle(color: Colors.lightGreen[900])),
            onTap: (){},
          ),
           ListTile(
            leading:  Icon(Icons.login, color: Colors.lightGreen[900]),
            title:  Text('Login', style: TextStyle(color: Colors.lightGreen[900])),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
