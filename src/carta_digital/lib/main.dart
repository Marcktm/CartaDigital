import 'package:carta_digital/services/servicio_google_sheets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase/firebase_options.dart';
import 'providers/pedido_provider.dart';
import 'providers/constante_autenticacion.dart'; 
import 'views/pantalla_login.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Inicializa bindings antes de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Carga configuración de Firebase
  );

  await UserSheetApi.getinstance().init();



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Estado de login
        ChangeNotifierProvider(create: (_) => PedidoProvider()), // Estado de pedidos
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carta_Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          // Si no hay usuario, va a Login; si hay usuario, va a HomeScreen original
          return authProvider.user == null
              ? const LoginScreen()
              : const HomeScreen(); 
        },
      ),
    );
  }
}
