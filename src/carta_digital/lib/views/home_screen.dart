import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/producto_repository.dart'; 
import '../widgets/producto_card.dart';
import '../widgets/resumen_pedido.dart';
import 'package:provider/provider.dart';
import '../providers/pedido_provider.dart';
import '../widgets/randomwidgets.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PedidoProvider>().cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    final pedidoProvider = context.watch<PedidoProvider>();
    final empanadas = pedidoProvider.empanadas;
    final bebidas = pedidoProvider.bebidas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre Local de Comidas'),
        backgroundColor: const Color.fromARGB(255, 255, 68, 0),
        foregroundColor: Colors.white,
        actions: const [
        Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: LogoutButton(),
                ),],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Nuestra Carta",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          ...empanadas.map((p) => ProductoCard(producto: p)),
          const SizedBox(height: 20),
          const Text(
            "Bebidas",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          ...bebidas.map((p) => ProductoCard(producto: p)),
          const Divider(),
          const ResumenPedido(),
        ],
      ),
    );
  }
}
