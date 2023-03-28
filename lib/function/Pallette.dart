// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart'; 
class Palette { 
  // ignore: constant_identifier_names
  static const MaterialColor FavoriteColor = const MaterialColor( 
    0xff10122A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffe2e3e5 ),//10% 
      100: const Color(0xffb7b8bf),//20% 
      200: const Color(0xff888995),//30% 
      300: const Color(0xff58596a),//40% 
      400: const Color(0xff34364a),//50% 
      500: const Color(0xff10122a),//60% 
      600: const Color(0xff0e1025),//70% 
      700: const Color(0xff0c0d1f),//80% 
      800: const Color(0xff090a19),//90% 
      900: const Color(0xff05050f),//100% 
    }, 
  ); 
}