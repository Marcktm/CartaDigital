class Producto {
  final String nombre;
  final double precio;
  final String categoria;

  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'],
      precio: json['precio'].toDouble(),
      categoria: json['categoria'],
    );
  }
}
