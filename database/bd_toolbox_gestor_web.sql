DROP DATABASE IF EXISTS bd_toolbox_gestor_web;
CREATE DATABASE bd_toolbox_gestor_web
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bd_toolbox_gestor_web;

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255),
    estado TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(150) NOT NULL,
    ruc VARCHAR(11) NOT NULL UNIQUE,
    telefono VARCHAR(20),
    correo VARCHAR(120),
    direccion VARCHAR(200),
    estado TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    tipo_documento VARCHAR(10) NOT NULL,
    numero_documento VARCHAR(11) NOT NULL UNIQUE,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    razon_social VARCHAR(150),
    telefono VARCHAR(20),
    correo VARCHAR(120),
    direccion VARCHAR(200),
    estado TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo_producto VARCHAR(20) NOT NULL UNIQUE,
    nombre_producto VARCHAR(150) NOT NULL,
    descripcion VARCHAR(255),
    id_categoria INT NOT NULL,
    id_proveedor INT NOT NULL,
    unidad_medida VARCHAR(30) NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 0,
    estado TINYINT(1) NOT NULL DEFAULT 1,
    CONSTRAINT fk_producto_categoria
        FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_producto_proveedor
        FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_producto_precio_compra CHECK (precio_compra > 0),
    CONSTRAINT chk_producto_precio_venta CHECK (precio_venta > 0),
    CONSTRAINT chk_producto_stock CHECK (stock >= 0),
    CONSTRAINT chk_producto_stock_minimo CHECK (stock_minimo >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    observacion VARCHAR(255),
    estado VARCHAR(20) NOT NULL DEFAULT 'REGISTRADA',
    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE detalle_venta (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta) REFERENCES venta(id_venta)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_detalle_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_detalle_precio CHECK (precio_unitario > 0),
    CONSTRAINT chk_detalle_subtotal CHECK (subtotal > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_categoria_nombre ON categoria(nombre);
CREATE INDEX idx_proveedor_busqueda ON proveedor(razon_social, ruc);
CREATE INDEX idx_cliente_busqueda ON cliente(nombres, apellidos, numero_documento);
CREATE INDEX idx_producto_busqueda ON producto(nombre_producto, codigo_producto);
CREATE INDEX idx_producto_stock ON producto(stock, stock_minimo);
CREATE INDEX idx_venta_fecha ON venta(fecha_venta);

INSERT INTO categoria (id_categoria, nombre, descripcion, estado) VALUES
(1, 'Herramientas manuales', 'Martillos, alicates, destornilladores, llaves y herramientas de uso diario.', 1),
(2, 'Herramientas electricas', 'Taladros, esmeriles y equipos electricos para trabajo de obra.', 1),
(3, 'Construccion', 'Cemento, ladrillos, agregados, clavos y materiales para obra.', 1),
(4, 'Pinturas', 'Pinturas, brochas, rodillos, solventes y accesorios para acabado.', 1),
(5, 'Electricidad', 'Cables, focos, interruptores, tomacorrientes y tableros electricos.', 1),
(6, 'Gasfiteria', 'Tubos PVC, codos, llaves de paso y accesorios sanitarios.', 1),
(7, 'Seguridad', 'Candados, chapas, cascos y articulos de proteccion.', 1),
(8, 'Adhesivos y selladores', 'Pegamentos, siliconas, selladores y cintas para reparaciones.', 1);

INSERT INTO proveedor (id_proveedor, razon_social, ruc, telefono, correo, direccion, estado) VALUES
(1, 'Distribuidora Ferretera Central S.A.C.', '20601234561', '987654321', 'ventas@ferrecentral.pe', 'Av. Industrial 145, Lima', 1),
(2, 'Comercial Andina de Materiales E.I.R.L.', '20599887761', '965874123', 'contacto@andinamateriales.pe', 'Jr. Los Alamos 230, Pasco', 1),
(3, 'Importaciones Herramax S.A.C.', '20604567891', '944556677', 'pedidos@herramax.pe', 'Av. Argentina 1200, Lima', 1),
(4, 'Electricos del Centro S.R.L.', '20456789123', '932118745', 'ventas@electricentro.pe', 'Av. Daniel Alcides Carrion 520, Pasco', 1),
(5, 'Pinturas y Acabados Peru S.A.C.', '20607894512', '955667788', 'atencion@pinturasperu.pe', 'Av. Los Proceres 410, Huancayo', 1),
(6, 'Sanitarios Quiparacra E.I.R.L.', '20512378945', '900749742', 'sanitarios@quiparacra.pe', 'Calle San Cristobal S/N, Quiparacra', 1);

INSERT INTO cliente (id_cliente, tipo_documento, numero_documento, nombres, apellidos, razon_social, telefono, correo, direccion, estado) VALUES
(1, 'DNI', '74125896', 'Carlos Alberto', 'Ramos Huaman', NULL, '987112233', 'carlos.ramos@mail.com', 'Quiparacra, Pasco', 1),
(2, 'DNI', '70214587', 'Mariela', 'Torres Rojas', NULL, '956778899', 'mariela.torres@mail.com', 'Huachon, Pasco', 1),
(3, 'DNI', '41879632', 'Jose Luis', 'Quispe Flores', NULL, '945123678', 'jose.quispe@mail.com', 'Calle Comercio 125, Pasco', 1),
(4, 'DNI', '46895123', 'Rosa Elena', 'Paredes Soto', NULL, '933451267', 'rosa.paredes@mail.com', 'Jr. Grau 220, Pasco', 1),
(5, 'DNI', '73261485', 'Miguel Angel', 'Salazar Vega', NULL, '922334455', 'miguel.salazar@mail.com', 'Quiparacra, Pasco', 1),
(6, 'DNI', '61827394', 'Ana Lucia', 'Mendoza Arias', NULL, '988776655', 'ana.mendoza@mail.com', 'Huachon, Pasco', 1),
(7, 'DNI', '42819376', 'Victor Hugo', 'Canchari Leon', NULL, '977445566', 'victor.canchari@mail.com', 'Pasco', 1),
(8, 'DNI', '70918263', 'Diana Carolina', 'Meza Campos', NULL, '966554433', 'diana.meza@mail.com', 'Quiparacra, Pasco', 1),
(9, 'DNI', '45271836', 'Edwin', 'Rojas Palomino', NULL, '955443322', 'edwin.rojas@mail.com', 'Huachon, Pasco', 1),
(10, 'DNI', '78451236', 'Patricia', 'Lopez Rivera', NULL, '944332211', 'patricia.lopez@mail.com', 'Pasco', 1),
(11, 'RUC', '20611122334', NULL, NULL, 'Constructora Huachon S.A.C.', '989898989', 'compras@huachonconstructora.pe', 'Av. Principal 350, Huachon', 1),
(12, 'RUC', '20555566778', NULL, NULL, 'Servicios Generales El Mirador E.I.R.L.', '976543210', 'administracion@elmirador.pe', 'Jr. Mirador 101, Pasco', 1),
(13, 'RUC', '20444111222', NULL, NULL, 'Mantenimiento Integral Pasco S.R.L.', '965432100', 'contacto@mipasco.pe', 'Av. Minera 440, Pasco', 1),
(14, 'RUC', '20600988776', NULL, NULL, 'Inversiones Quiparacra E.I.R.L.', '954321000', 'ventas@inverquiparacra.pe', 'Quiparacra, Pasco', 1),
(15, 'RUC', '20567812349', NULL, NULL, 'Multiservicios San Cristobal S.A.C.', '943210000', 'compras@sacristobal.pe', 'Calle San Cristobal S/N, Quiparacra', 1);

INSERT INTO producto (id_producto, codigo_producto, nombre_producto, descripcion, id_categoria, id_proveedor, unidad_medida, precio_compra, precio_venta, stock, stock_minimo, estado) VALUES
(1, 'HM-001', 'Martillo de acero', 'Martillo de acero forjado con mango de madera para trabajos generales.', 1, 3, 'Unidad', 18.00, 28.90, 20, 5, 1),
(2, 'HM-002', 'Destornillador estrella', 'Destornillador punta estrella PH2 con mango antideslizante.', 1, 3, 'Unidad', 4.50, 7.50, 30, 8, 1),
(3, 'HM-003', 'Alicate universal', 'Alicate multiuso para corte, sujecion y doblado.', 1, 3, 'Unidad', 15.00, 24.50, 18, 5, 1),
(4, 'HM-004', 'Llave francesa 10 pulgadas', 'Llave ajustable de acero para trabajos de mantenimiento.', 1, 3, 'Unidad', 21.00, 34.90, 10, 4, 1),
(5, 'HM-005', 'Cinta metrica 5m', 'Cinta metrica retractil de 5 metros con freno.', 1, 1, 'Unidad', 7.00, 12.50, 25, 5, 1),
(6, 'HM-006', 'Serrucho 22 pulgadas', 'Serrucho para corte de madera con dientes endurecidos.', 1, 3, 'Unidad', 18.00, 29.90, 5, 5, 1),
(7, 'HE-001', 'Taladro percutor 650W', 'Taladro percutor para perforacion en madera, metal y concreto.', 2, 3, 'Unidad', 120.00, 189.90, 6, 2, 1),
(8, 'HE-002', 'Esmeril angular 4 1/2', 'Esmeril angular para corte y desbaste en trabajos de obra.', 2, 3, 'Unidad', 98.00, 159.00, 4, 2, 1),
(9, 'CO-001', 'Cemento Portland 42.5kg', 'Bolsa de cemento tipo I para construccion general.', 3, 2, 'Bolsa', 27.00, 34.90, 50, 10, 1),
(10, 'CO-002', 'Ladrillo King Kong 18 huecos', 'Ladrillo para muros portantes y trabajos de albanileria.', 3, 2, 'Unidad', 0.80, 1.20, 500, 100, 1),
(11, 'CO-003', 'Arena gruesa 40kg', 'Arena gruesa lavada en bolsa para mezclas de concreto.', 3, 2, 'Bolsa', 8.00, 12.90, 40, 10, 1),
(12, 'CO-004', 'Clavos de 2 pulgadas', 'Clavos de acero en bolsa de 1kg para madera y encofrado.', 3, 1, 'Bolsa', 5.00, 8.50, 40, 10, 1),
(13, 'PI-001', 'Pintura latex blanco 4L', 'Pintura latex blanca para interiores y exteriores.', 4, 5, 'Galon', 32.00, 48.00, 16, 5, 1),
(14, 'PI-002', 'Brocha 4 pulgadas', 'Brocha de cerdas naturales para pintura en pared y madera.', 4, 5, 'Unidad', 5.00, 9.50, 25, 8, 1),
(15, 'PI-003', 'Rodillo de pintura 9 pulgadas', 'Rodillo de felpa para paredes y superficies amplias.', 4, 5, 'Unidad', 9.00, 15.90, 13, 5, 1),
(16, 'EL-001', 'Cable THW 2.5mm', 'Cable electrico THW 2.5mm para circuitos de iluminacion.', 5, 4, 'Metro', 2.40, 3.80, 100, 30, 1),
(17, 'EL-002', 'Foco LED 9W', 'Foco LED de luz blanca con rosca E27.', 5, 4, 'Unidad', 5.00, 8.50, 60, 20, 1),
(18, 'EL-003', 'Interruptor simple', 'Interruptor simple 10A para instalacion empotrada.', 5, 4, 'Unidad', 4.50, 7.90, 22, 6, 1),
(19, 'EL-004', 'Tablero electrico 4 polos', 'Tablero electrico metalico para distribucion basica.', 5, 4, 'Unidad', 45.00, 69.00, 4, 5, 1),
(20, 'GA-001', 'Tubo PVC 2 pulgadas x 3m', 'Tubo PVC para instalaciones sanitarias y desague.', 6, 6, 'Unidad', 11.00, 16.90, 25, 7, 1),
(21, 'GA-002', 'Codo PVC 2 pulgadas', 'Codo PVC 90 grados para instalaciones sanitarias.', 6, 6, 'Unidad', 2.70, 4.50, 35, 10, 1),
(22, 'GA-003', 'Pegamento PVC 250ml', 'Pegamento para union de tuberias PVC.', 6, 6, 'Unidad', 7.50, 11.90, 18, 6, 1),
(23, 'GA-004', 'Llave de paso 1/2 pulgada', 'Llave de paso de bronce para agua fria o caliente.', 6, 6, 'Unidad', 10.00, 16.50, 12, 4, 1),
(24, 'AD-001', 'Cinta teflon', 'Cinta teflon para sellado de roscas en gasfiteria.', 8, 6, 'Unidad', 1.20, 2.50, 50, 15, 1),
(25, 'SE-001', 'Candado 40mm', 'Candado de acero para puertas, portones y almacenes.', 7, 1, 'Unidad', 11.00, 17.90, 15, 5, 1),
(26, 'SE-002', 'Chapa puerta principal', 'Chapa de sobreponer para puerta principal.', 7, 1, 'Unidad', 24.00, 35.00, 7, 3, 1),
(27, 'SE-003', 'Casco de seguridad', 'Casco de seguridad para trabajos de obra.', 7, 2, 'Unidad', 16.00, 25.00, 3, 4, 1),
(28, 'AD-002', 'Tornillo madera 2 pulgadas', 'Caja de tornillos para madera de 2 pulgadas.', 8, 1, 'Caja', 6.00, 9.90, 25, 8, 1),
(29, 'AD-003', 'Sellador sanitario', 'Silicona sanitaria transparente para banos y cocinas.', 8, 5, 'Unidad', 9.00, 14.90, 8, 4, 1),
(30, 'CO-005', 'Carretilla construccion 80L', 'Carretilla metalica para traslado de materiales.', 3, 2, 'Unidad', 90.00, 135.00, 2, 3, 1);

INSERT INTO venta (id_venta, id_cliente, fecha_venta, total, observacion, estado) VALUES
(1, 1, '2026-06-01 09:20:00', 91.80, 'Venta de herramientas y focos.', 'REGISTRADA'),
(2, 11, '2026-06-02 10:35:00', 191.50, 'Materiales para obra menor.', 'REGISTRADA'),
(3, 3, '2026-06-03 15:10:00', 80.60, 'Accesorios de gasfiteria.', 'REGISTRADA'),
(4, 4, '2026-06-04 11:45:00', 130.90, 'Productos para pintado de ambiente.', 'REGISTRADA'),
(5, 5, '2026-06-05 17:05:00', 72.70, 'Articulos de seguridad y fijacion.', 'REGISTRADA');

INSERT INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 2, 28.90, 57.80),
(1, 17, 4, 8.50, 34.00),
(2, 9, 5, 34.90, 174.50),
(2, 12, 2, 8.50, 17.00),
(3, 20, 3, 16.90, 50.70),
(3, 21, 4, 4.50, 18.00),
(3, 22, 1, 11.90, 11.90),
(4, 13, 2, 48.00, 96.00),
(4, 14, 2, 9.50, 19.00),
(4, 15, 1, 15.90, 15.90),
(5, 25, 1, 17.90, 17.90),
(5, 26, 1, 35.00, 35.00),
(5, 28, 2, 9.90, 19.80);

UPDATE producto SET stock = stock - 2 WHERE id_producto = 1;
UPDATE producto SET stock = stock - 4 WHERE id_producto = 17;
UPDATE producto SET stock = stock - 5 WHERE id_producto = 9;
UPDATE producto SET stock = stock - 2 WHERE id_producto = 12;
UPDATE producto SET stock = stock - 3 WHERE id_producto = 20;
UPDATE producto SET stock = stock - 4 WHERE id_producto = 21;
UPDATE producto SET stock = stock - 1 WHERE id_producto = 22;
UPDATE producto SET stock = stock - 2 WHERE id_producto = 13;
UPDATE producto SET stock = stock - 2 WHERE id_producto = 14;
UPDATE producto SET stock = stock - 1 WHERE id_producto = 15;
UPDATE producto SET stock = stock - 1 WHERE id_producto = 25;
UPDATE producto SET stock = stock - 1 WHERE id_producto = 26;
UPDATE producto SET stock = stock - 2 WHERE id_producto = 28;
