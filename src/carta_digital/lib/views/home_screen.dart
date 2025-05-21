import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../models/producto_repository.dart'; // 👈 nueva clase
import '../widgets/producto_card.dart';
import '../widgets/resumen_pedido.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductoRepository repo = ProductoRepository();
  List<Producto> empanadas = [];
  List<Producto> bebidas = [];

  Future<void> cargarProductos() async {
    empanadas = await repo.cargarPorCategoria('comida');
    bebidas = await repo.cargarPorCategoria('bebida');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre Local de Comidas'),
        backgroundColor: const Color.fromARGB(255, 255, 68, 0),
        foregroundColor: Colors.white,
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
