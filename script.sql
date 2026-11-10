-- Base de Datos I - Unidad 4 - Ej12: RedSocialFotografias
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS publicacion_etiqueta;
DROP TABLE IF EXISTS REACCION;
DROP TABLE IF EXISTS seguidor_seguido;
DROP TABLE IF EXISTS ETIQUETA;
DROP TABLE IF EXISTS COMENTARIO;
DROP TABLE IF EXISTS PUBLICACION;
DROP TABLE IF EXISTS USUARIO;

CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email_usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(100),
    biografia VARCHAR(100),
    fecha_alta DATE,
    nombre_visible VARCHAR(50)
);

CREATE TABLE PUBLICACION (
    id_publicacion INT PRIMARY KEY,
    id_usuario_autor INT,
    url_imagen VARCHAR(100),
    leyenda VARCHAR(50),
    fecha_hora_publicacion DATETIME,
    estado_publicacion VARCHAR(50),
    ubicacion VARCHAR(100),
    FOREIGN KEY (id_usuario_autor) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE COMENTARIO (
    id_comentario INT PRIMARY KEY,
    id_usuario INT,
    id_publicacion INT,
    id_comentario_padre INT,
    texto_comentario VARCHAR(50),
    fecha_hora_emision DATE,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_publicacion) REFERENCES PUBLICACION(id_publicacion),
    FOREIGN KEY (id_comentario_padre) REFERENCES COMENTARIO(id_comentario)
);

CREATE TABLE ETIQUETA (
    id_etiqueta INT PRIMARY KEY,
    nombre_etiqueta VARCHAR(50),
    descripcion_etiqueta VARCHAR(100),
    categoria VARCHAR(50),
    fecha_creacion DATE,
    cantidad_usos INT
);

CREATE TABLE seguidor_seguido (
    id_seguimiento INT PRIMARY KEY,
    id_seguidor INT,
    id_seguido INT,
    fecha_seguimiento DATE,
    FOREIGN KEY (id_seguidor) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_seguido) REFERENCES USUARIO(id_usuario)
);

CREATE TABLE REACCION (
    id_reaccion INT PRIMARY KEY,
    id_usuario INT,
    id_publicacion INT,
    tipo_reaccion VARCHAR(50),
    fecha_hora_reaccion DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_publicacion) REFERENCES PUBLICACION(id_publicacion)
);

CREATE TABLE publicacion_etiqueta (
    id_pub_etiq INT PRIMARY KEY,
    id_publicacion INT,
    id_etiqueta INT,
    fecha_asociacion DATE,
    FOREIGN KEY (id_publicacion) REFERENCES PUBLICACION(id_publicacion),
    FOREIGN KEY (id_etiqueta) REFERENCES ETIQUETA(id_etiqueta)
);

-- Datos de USUARIO
INSERT INTO USUARIO (id_usuario, username, email_usuario, nombre_visible, fecha_alta) VALUES (1, 'lucia_foto', 'lucia@mail.com', 'Lucía', '2025-11-01');
INSERT INTO USUARIO (id_usuario, username, email_usuario, nombre_visible, fecha_alta) VALUES (2, 'marcos.ph', 'marcos@mail.com', 'Marcos', '2025-12-10');
INSERT INTO USUARIO (id_usuario, username, email_usuario, nombre_visible, fecha_alta) VALUES (3, 'nico_lens', 'nico@mail.com', 'Nico', '2026-01-05');
INSERT INTO USUARIO (id_usuario, username, email_usuario, nombre_visible, fecha_alta) VALUES (4, 'tomi_pics', 'tomi@mail.com', 'Tomi', '2026-02-15');

-- Datos de PUBLICACION
INSERT INTO PUBLICACION (id_publicacion, id_usuario_autor, leyenda, fecha_hora_publicacion, estado_publicacion) VALUES (1, 1, 'Atardecer en Uspallata', '2026-04-02 19:30', 'Publicada');
INSERT INTO PUBLICACION (id_publicacion, id_usuario_autor, leyenda, fecha_hora_publicacion, estado_publicacion) VALUES (2, 2, 'Retrato en blanco y negro', '2026-04-09 15:45', 'Publicada');
INSERT INTO PUBLICACION (id_publicacion, id_usuario_autor, leyenda, fecha_hora_publicacion, estado_publicacion) VALUES (3, 3, 'Calle de Buenos Aires', '2026-04-12 12:00', 'Archivada');
INSERT INTO PUBLICACION (id_publicacion, id_usuario_autor, leyenda, fecha_hora_publicacion, estado_publicacion) VALUES (4, 4, 'Playa al amanecer', '2026-04-20 06:50', 'Publicada');

-- Datos de COMENTARIO
INSERT INTO COMENTARIO (id_comentario, id_usuario, id_publicacion, id_comentario_padre, texto_comentario) VALUES (1, 2, 1, NULL, '¡Hermosa foto!');
INSERT INTO COMENTARIO (id_comentario, id_usuario, id_publicacion, id_comentario_padre, texto_comentario) VALUES (2, 3, 1, 1, 'Coincido, qué colores');
INSERT INTO COMENTARIO (id_comentario, id_usuario, id_publicacion, id_comentario_padre, texto_comentario) VALUES (3, 1, 1, 2, 'Gracias a los dos');
INSERT INTO COMENTARIO (id_comentario, id_usuario, id_publicacion, id_comentario_padre, texto_comentario) VALUES (4, 4, 2, NULL, 'Muy buena composición');

-- Datos de ETIQUETA
INSERT INTO ETIQUETA (id_etiqueta, nombre_etiqueta, categoria, cantidad_usos, fecha_creacion) VALUES (1, '#atardecer', 'Paisaje', 120, '2025-11-02');
INSERT INTO ETIQUETA (id_etiqueta, nombre_etiqueta, categoria, cantidad_usos, fecha_creacion) VALUES (2, '#montaña', 'Paisaje', 85, '2025-11-15');
INSERT INTO ETIQUETA (id_etiqueta, nombre_etiqueta, categoria, cantidad_usos, fecha_creacion) VALUES (3, '#retrato', 'Retrato', 60, '2025-12-01');
INSERT INTO ETIQUETA (id_etiqueta, nombre_etiqueta, categoria, cantidad_usos, fecha_creacion) VALUES (4, '#ciudad', 'Urbano', 40, '2026-01-10');

-- Datos de seguidor_seguido
INSERT INTO seguidor_seguido (id_seguimiento, id_seguidor, id_seguido, fecha_seguimiento) VALUES (1, 1, 2, '2026-01-10');
INSERT INTO seguidor_seguido (id_seguimiento, id_seguidor, id_seguido, fecha_seguimiento) VALUES (2, 1, 3, '2026-01-15');
INSERT INTO seguidor_seguido (id_seguimiento, id_seguidor, id_seguido, fecha_seguimiento) VALUES (3, 2, 1, '2026-02-01');
INSERT INTO seguidor_seguido (id_seguimiento, id_seguidor, id_seguido, fecha_seguimiento) VALUES (4, 3, 1, '2026-02-20');

-- Datos de REACCION
INSERT INTO REACCION (id_reaccion, id_usuario, id_publicacion, tipo_reaccion, fecha_hora_reaccion) VALUES (1, 2, 1, 'Me gusta', '2026-04-02 20:00');
INSERT INTO REACCION (id_reaccion, id_usuario, id_publicacion, tipo_reaccion, fecha_hora_reaccion) VALUES (2, 3, 1, 'Me encanta', '2026-04-02 21:10');
INSERT INTO REACCION (id_reaccion, id_usuario, id_publicacion, tipo_reaccion, fecha_hora_reaccion) VALUES (3, 1, 2, 'Me gusta', '2026-04-12 12:30');
INSERT INTO REACCION (id_reaccion, id_usuario, id_publicacion, tipo_reaccion, fecha_hora_reaccion) VALUES (4, 4, 1, 'Me gusta', '2026-04-20 07:15');

-- Datos de publicacion_etiqueta
INSERT INTO publicacion_etiqueta (id_pub_etiq, id_publicacion, id_etiqueta, fecha_asociacion) VALUES (1, 1, 1, '2026-04-02');
INSERT INTO publicacion_etiqueta (id_pub_etiq, id_publicacion, id_etiqueta, fecha_asociacion) VALUES (2, 1, 2, '2026-04-02');
INSERT INTO publicacion_etiqueta (id_pub_etiq, id_publicacion, id_etiqueta, fecha_asociacion) VALUES (3, 2, 3, '2026-04-09');
INSERT INTO publicacion_etiqueta (id_pub_etiq, id_publicacion, id_etiqueta, fecha_asociacion) VALUES (4, 3, 4, '2026-04-12');
