import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/ClientHttp.Service.dart';
import 'package:new_york_delivery_app/app/views/Contact%20Me%20Screen/contact_me.screen.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/login.screen.dart';
import 'package:new_york_delivery_app/app/views/Profile%20Screen/profile.screen.dart';
import 'package:new_york_delivery_app/app/views/Reset%20password%20screen/reset_password.screen.dart';
import 'package:new_york_delivery_app/app/views/Sign%20up%20screen/sign-up.screen.dart';

import 'interfaces/IClientHttp.interface.dart';

class AppModule extends Module {
@override
  List<Bind> get binds => [
    Bind<IHttp>((i) => HttpService()),
    Bind<ApiClientRepository>((i) => ApiClientRepository(client:i.get())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/Login', child: (_,args) => const LoginScreen()),
    ChildRoute('/Sign-up', child: (_,args) => const SignUpScreen()),
    ChildRoute('/Reset-password', child: (_,args) => const ResetPasswordScreen()),
    ChildRoute('/Contact-me', child: (_,args) => const ContactMeScreen()),
    ChildRoute('/Profile', child: (_,args) => const ProfileScreen()),
  ];
}