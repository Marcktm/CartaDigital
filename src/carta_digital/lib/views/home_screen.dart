import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/pedido_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Producto> empanadas = [];
  List<Producto> bebidas = [];

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    final String jsonString = await rootBundle.loadString('assets/data/menu.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    final productos = jsonData.map((e) => Producto.fromJson(e)).toList();
    setState(() {
      empanadas = productos.where((p) => p.categoria == 'comida').toList();
      bebidas = productos.where((p) => p.categoria == 'bebida').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pedido = Provider.of<PedidoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCAL DE COMIDA'),
        backgroundColor: const Color.fromARGB(255, 199, 28, 16),
        foregroundColor: const Color.fromARGB(255, 253, 253, 253),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Empanadas", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ...empanadas.map((p) => _buildProductoTile(p, pedido)),
          const SizedBox(height: 20),
          const Text("Bebidas", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ...bebidas.map((p) => _buildProductoTile(p, pedido)),
          const Divider(),
          Text("Total: \$${pedido.total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => pedido.resetear(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Resetear Pedido"),
          ),
        ],
      ),
    );
  }

  Widget _buildProductoTile(Producto p, PedidoProvider pedido) {
    final cantidad = pedido.cantidades[p] ?? 0;
    return Card(
      child: ListTile(
        title: Text(p.nombre),
        subtitle: Text("Precio: \$${p.precio}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => pedido.disminuir(p, 1), icon: const Icon(Icons.remove)),
            Text('$cantidad'),
            IconButton(onPressed: () => pedido.aumentar(p, 1), icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
