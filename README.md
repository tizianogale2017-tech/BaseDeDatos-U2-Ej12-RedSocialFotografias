# BaseDeDatos-U2-Ej12-RedSocialFotografias
Base de Datos - Unidad 2 - Ejercicio 12

Consigna

Modelar la estructura conceptual de una red social de fotografía: perfiles de usuario con seguimiento entre ellos, publicaciones con hashtags, comentarios encadenados en árbol y reacciones únicas por usuario y publicación.

Lógica

Seguidores: autorrelación N:M sobre USUARIO. Un usuario sigue a muchos y es seguido por muchos, así que la autorrelación se resuelve con la entidad intermedia seguidor-seguido, conectada dos veces a USUARIO con los dos roles (sigue y es_seguido). Los dos roles son los que hacen que el seguimiento sea unidireccional: que A siga a B es una fila, y que B siga a A es otra distinta. La relación bidireccional (amistad mutua) no es una estructura aparte, es simplemente que existan las dos filas. fecha_seguimiento es atributo del vínculo.

Comentarios: autorrelación 1:N, no N:M. Acá está la diferencia clave con el caso anterior y es lo que conviene tener claro: un comentario puede tener muchas respuestas, pero cada respuesta cuelga de un solo comentario padre. Al ser 1:N recursiva no hace falta entidad intermedia: alcanza con la FK Id_Comentario_padre apuntando a la misma entidad y un rombo que vuelve sobre COMENTARIO con los roles padre / hijo. Los comentarios raíz tienen ese campo en NULL, y el anidamiento en árbol sale de recorrer la jerarquía.

Publicación ↔ Etiqueta: N:M con publicacion-etiqueta. Una publicación lleva muchos hashtags y un hashtag agrupa muchas publicaciones. ETIQUETA es entidad propia (no un texto repetido dentro de la publicación) porque el enunciado pide que el nombre sea único y porque así se pueden buscar todas las publicaciones de #sunset sin recorrer texto libre.

Reacciones: N:M entre USUARIO y PUBLICACION resuelto con REACCION. El tipo_reaccion (Me gusta / Me encanta / Asombroso) es atributo del vínculo: depende de quién reacciona y a qué. La regla de que un usuario no pueda duplicar su reacción se garantiza con una clave candidata UNIQUE sobre (username, Id_Publicacion): la PK artificial Id_Reaccion identifica la fila, pero el par usuario-publicación no puede repetirse. Si el usuario cambia de "Me gusta" a "Me encanta", se actualiza la fila existente en lugar de insertar una nueva.

Los comentarios cuelgan de la publicación y del usuario por separado. COMENTARIO tiene dos relaciones 1:N entrantes (quién lo escribió y dónde), que no son redundantes entre sí: el autor del comentario no tiene por qué ser el de la publicación.

Restricciones de integridad a considerar: en seguidor-seguido, UNIQUE sobre el par de usernames y un CHECK que impida que un usuario se siga a sí mismo; en COMENTARIO, que Id_Comentario_padre apunte a un comentario de la misma publicación y control de ciclos en el árbol; borrado en cascada de comentarios y reacciones al eliminar una publicación.

Resultado
<img width="4500" height="2871" alt="BaseDeDatos-U2-Ej12-RedSocialFotografias" src="https://github.com/user-attachments/assets/266f0511-efe4-4719-9a11-23d75c51356d" />
