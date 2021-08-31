import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool keepLogged = false;
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                height: 60.0,
                width: double.infinity,
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
              Container(
                margin: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.menu,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Menu",
                            style: TextStyle(
                              color: Colors.lightGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.home,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Change Deli",
                            style: TextStyle(
                              color: Colors.lightGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.mail,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Contact Us",
                            style: TextStyle(
                              color: Colors.lightGreen,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Colors.lightGreen,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.lightGreen,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/background.png",
                ),
                fit: BoxFit.fill),
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            const Text("Don't have an account? ",
                                style: TextStyle(fontSize: 12.0)),
                            GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "Click Here ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12.0),
                                )),
                            const Text(
                              "to sign up.",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                side: const BorderSide(color: Colors.lightGreen),
                                checkColor: Colors.black, // color of tick Mark
                                activeColor: Colors.grey,
                                value: keepLogged,
                                onChanged: (newValue) {
                                  setState(() {
                                    keepLogged = newValue!;
                                  });
                                }),
                            const Text(
                              "Keep me logged",
                            ),
                            
                          ],
                        ),
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              const Text(
                                "E-mail",
                              ),
                              TextField(
                                onChanged: (String value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.lightGreen,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              const Text(
                                "Password",
                              ),
                              TextField(
                                onChanged: (String value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                cursorColor: Colors.lightGreen,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "RESET PASSWORD",
                                      style: TextStyle(
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.lightGreen[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: Container(
                                    width: 250,
                                    height: 30.0,
                                    child: const Center(
                                      child: Text(
                                        "LOG IN",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
