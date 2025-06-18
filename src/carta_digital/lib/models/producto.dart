class Producto {
  final String nombre;
  final double precio;
  final String categoria;
  final bool stock;

  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
    required this.stock,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'],
      precio: json['precio'].toDouble(),
      categoria: json['categoria'],
      stock: json['stock'].toString().toLowerCase() == 'si',
    );
  }
}
