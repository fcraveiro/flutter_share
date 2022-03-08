import 'package:flutter_share/paginas/sharear.dart';

import '/menu.dart';
import '/paginas/pagina1.dart';
import 'package:get/get.dart';

rotas() {
  return [
    GetPage(name: '/', page: () => const Menu()),
    GetPage(
        name: '/menu/', page: () => const Menu(), transition: Transition.zoom),
    GetPage(
        name: '/pagina1/',
        page: () => const Pagina1(),
        transition: Transition.zoom),
    GetPage(
        name: '/sharear/',
        page: () => const Sharear(),
        transition: Transition.zoom),
  ];
}
