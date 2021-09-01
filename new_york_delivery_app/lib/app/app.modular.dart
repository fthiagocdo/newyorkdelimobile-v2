import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/ClientHttp.Service.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/login.screen.dart';

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
  ];
}