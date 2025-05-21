import 'dart:convert';
import 'package:flutter/services.dart';
import 'producto.dart';

class ProductoRepository {
  Future<List<Producto>> cargarDesdeJson() async {
    final String jsonString = await rootBundle.loadString('assets/data/menu.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((e) => Producto.fromJson(e)).toList();
  }

  Future<List<Producto>> cargarPorCategoria(String categoria) async {
    final productos = await cargarDesdeJson();
    return productos.where((p) => p.categoria == categoria).toList();
  }
}
