import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/pedido_provider.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  const ProductoCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PedidoProvider>(context);
    final cantidad = provider.pedido.cantidades[producto] ?? 0;

    return Card(
      child: ListTile(
        title: Text(producto.nombre),
        subtitle: Text("Precio: \$${producto.precio}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () => provider.disminuir(producto, 1), icon: const Icon(Icons.remove)),
            Text('$cantidad'),
            IconButton(onPressed: () => provider.aumentar(producto, 1), icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
