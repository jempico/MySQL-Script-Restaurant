
Leyenda gráfica del Diagrama ER:
- Las claves primarias se identifican en el diagrama en negrita. 
- Todas las claves, tanto foráneas como primarias, se identifican con un fondo azul cielo.

Observaciones:

- 'Product Type' y 'Product Category' son tratadas como entidades para facilitar la incorporación e interrelación de nuevas tipologías de producto y categorías de producto.

- En la tabla 'Producto', se define una variable tipo varchar para conservar la URL de la imagen

- En la tabla 'Driver', la id_employee es única para garantizar la relación 1-1 entre la tabla driver y la tabla employees (un único employee puede tener una única licencia de driver, y viceversa, una licencia solo puede ser asignada a un único employee).