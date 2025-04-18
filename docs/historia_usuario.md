# Historia de Usuario - Dueño del Restaurante

**Como** dueño de un restaurante, **quiero** una aplicación móvil que permita a los clientes ver y pedir platos disponibles en tiempo real, **y** que a su vez permita a mis empleados administrar el menú, gestionar el stock de ingredientes y agregar nuevos platos, **para** asegurar que los pedidos reflejen la disponibilidad real de la cocina, evitar rechazos por falta de ingredientes, y mantener una experiencia satisfactoria para el cliente.

## Detalles:

- Quiero que la app tenga dos tipos de acceso: uno para **clientes**, que puedan navegar el menú, elegir platos, hacer pedidos y seguir su estado; y otro para **administradores**, que puedan modificar el menú, registrar la llegada de ingredientes y dar de baja platos temporalmente si no se pueden preparar.
- Necesito que la disponibilidad de cada plato se calcule automáticamente según el stock actual de ingredientes. Si no hay suficiente cantidad para preparar un plato, este **no debe mostrarse en el menú del cliente**.
- Me interesa que el sistema sea **modular y configurable**, para poder agregar nuevos platos fácilmente, sin necesidad de modificar todo el sistema.
- Quiero que los administradores puedan **loggearse** con credenciales seguras y que los clientes también puedan registrarse o ingresar para ver sus pedidos anteriores.
- Me gustaría tener la posibilidad de ver reportes simples sobre qué platos se pidieron más y qué ingredientes se usan más, para facilitar las compras.

## Criterios de Aceptación:

- ✅ La app debe mostrar a los clientes solo los platos que pueden prepararse en ese momento.
- ✅ Los administradores deben poder actualizar el stock de ingredientes desde la app.
- ✅ Al agregar un nuevo plato, debe poder definirse qué ingredientes necesita y en qué cantidad.
- ✅ Debe haber roles claramente diferenciados para clientes y administradores.
- ✅ El sistema debe ser intuitivo, adaptable a distintos tamaños de menú y sencillo de mantener.