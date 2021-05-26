-- --------------------------------------------------
-- CREACION DE BASE DE DATOS
-- --------------------------------------------------

CREATE DATABASE IF NOT EXISTS Bisonteca;
USE Bisonteca;

-- --------------------------------------------------
-- ELIMINACION DE TABLAS
-- --------------------------------------------------

DROP TABLE IF EXISTS curso_categoria;
DROP TABLE IF EXISTS multimedia_nivel;
DROP TABLE IF EXISTS venta;
DROP TABLE IF EXISTS historial_usuario;
DROP TABLE IF EXISTS nivel_curso;
DROP TABLE IF EXISTS comentario;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS mensaje;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS rol;
DROP TABLE IF EXISTS categoria;

-- --------------------------------------------------
-- CREACION DE TABLAS
-- --------------------------------------------------

# fk: usuario
CREATE TABLE rol
(
	id_rol				INT AUTO_INCREMENT PRIMARY KEY,
    nombre				VARCHAR(50) NOT NULL
);

# fk: rol
CREATE TABLE usuario
(
	id_usuario			INT AUTO_INCREMENT PRIMARY KEY,
    id_rol				INT NOT NULL,
    email				VARCHAR(100) NOT NULL,
    nick				VARCHAR(50) NOT NULL,
    password			VARCHAR(50) NOT NULL,
    nombre				VARCHAR(300) NULL,
    ap_paterno			VARCHAR(50) NULL,
    ap_materno			VARCHAR(50) NULL,
    imagen				MEDIUMBLOB NULL,
    tipo_imagen			VARCHAR(25),
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_usuario_usuario_rol FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);

CREATE TABLE categoria
(
	id_categoria		INT AUTO_INCREMENT PRIMARY KEY,
    nombre				VARCHAR(100) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE curso
(
	id_curso			INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario			INT NOT NULL,
    titulo				VARCHAR(100) NOT NULL,
    subtitulo			VARCHAR(250) NOT NULL,
    descripcion			VARCHAR(1000) NULL,
    precio				DECIMAL(18, 2) NOT NULL,
    activo				BIT NOT NULL DEFAULT 1,
    imagen				MEDIUMBLOB NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    tipo_imagen			VARCHAR(25) NULL,
    
    CONSTRAINT 			FK_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- ALTER TABLE curso ADD COLUMN tipo_imagen VARCHAR(25) NULL

CREATE TABLE curso_categoria
(
	id_curso_categoria  INT AUTO_INCREMENT PRIMARY KEY,
    id_curso			INT NOT NULL,
    id_categoria		INT NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_curso_categoria_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    CONSTRAINT 			FK_curso_categoria_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE mensaje
(
	id_mensaje			INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario_rem		INT NOT NULL,
    id_usuario_dest		INT NOT NULL,
    mensaje				VARCHAR(1000) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_mensaje_usuario_rem FOREIGN KEY (id_usuario_rem) REFERENCES usuario(id_usuario),
    CONSTRAINT 			FK_mensaje_usuario_dest	FOREIGN KEY (id_usuario_dest) REFERENCES usuario(id_usuario)
);

CREATE TABLE comentario
(
	id_comentario		INT AUTO_INCREMENT PRIMARY KEY,
    id_curso			INT NOT NULL,
    id_usuario			INT NOT NULL,
    comentario			VARCHAR(1000) NOT NULL,
    valoracion			INT NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_comentario_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    CONSTRAINT 			FK_comentario_usuario	FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE nivel_curso
(
	id_nivel_curso		INT AUTO_INCREMENT PRIMARY KEY,
    id_curso			INT NOT NULL,
    orden				INT NOT NULL,
    precio				DECIMAL(18,2),
    titulo				VARCHAR(100) NOT NULL,
    descripcion			VARCHAR(1000) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_nivel_curso_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE multimedia_nivel
(
	id_multimedia_nivel INT AUTO_INCREMENT PRIMARY KEY,
    id_nivel_curso		INT NOT NULL,
    ruta				VARCHAR(500) NOT NULL,
    nombre				VARCHAR(100) NOT NULL,
    extension			VARCHAR(25) NOT NULL,
    tipo				VARCHAR(250) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_multimedia_nivel_nivel_curso FOREIGN KEY (id_nivel_curso) REFERENCES nivel_curso(id_nivel_curso)
);

CREATE TABLE venta
(
	id_venta			INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario			INT NOT NULL,
    id_curso			INT NULL,
    id_nivel_curso		INT NULL,
    monto_pago			DECIMAL(18, 2),
    forma_pago			INT NOT NULL,
    fecha_finalizacion 	DATETIME NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_venta_curso FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    CONSTRAINT 			FK_venta_usuario	FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE historial_usuario
(
	id_historial_usuario 	INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario				INT NOT NULL,
    id_nivel_curso			INT NOT NULL,
    fecha_alta				DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod				DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 				FK_historial_usuario_nivel_curso FOREIGN KEY (id_nivel_curso) REFERENCES nivel_curso(id_nivel_curso),
    CONSTRAINT 				FK_historial_usuario_usuario	FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- --------------------------------------------------
-- FUNCIONES
-- --------------------------------------------------

DROP FUNCTION IF EXISTS fn_existe_curso;

DELIMITER //

CREATE FUNCTION fn_existe_curso
(
	id_usuario 	INT,
    titulo		VARCHAR(100)
)
RETURNS BOOL
DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_curso
						FROM	curso c
						WHERE	c.titulo = titulo
                        AND		c.id_usuario = id_usuario
					));
    
	RETURN (Existe);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_existe_nivel_curso;

DELIMITER //

CREATE FUNCTION fn_existe_nivel_curso
(
	id_curso 	INT,
    titulo		VARCHAR(100)
)
RETURNS BOOL
DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_nivel_curso
						FROM	nivel_curso nc
						WHERE	nc.titulo = titulo
                        AND		nc.id_curso = id_curso
					));
    
	RETURN (Existe);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_existe_archivo_nivel;

DELIMITER //

CREATE FUNCTION fn_existe_archivo_nivel
(
	id_nivel_curso 	INT,
    nombre			VARCHAR(100)
)
RETURNS BOOL
DETERMINISTIC
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(SELECT EXISTS(
						SELECT 	id_multimedia_nivel
						FROM	multimedia_nivel mn
						WHERE	mn.nombre = nombre
                        AND		mn.id_nivel_curso = id_nivel_curso
					));
    
	RETURN (Existe);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_precio_curso;

DELIMITER //

CREATE FUNCTION fn_precio_curso -- SELECT fn_precio_curso(2, 1)
(
	tipo		INT,
	id		 	INT
)
RETURNS DECIMAL(18, 2)
DETERMINISTIC
BEGIN

	DECLARE Precio DECIMAL(18, 2) DEFAULT 0;
    
    -- si es 1 es el precio de un curso
    IF tipo = 1 THEN
		SET Precio = (IFNULL((SELECT c.precio FROM curso c WHERE c.id_curso = id), 0));
    ELSE
    -- si es cualquier otro es el precio de un nivel de curso
		SET Precio = (IFNULL((SELECT nc.precio FROM nivel_curso nc WHERE nc.id_nivel_curso = id ), 0));
    END IF;
    
    
	RETURN (Precio);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_votos_positivos_curso;

DELIMITER //

CREATE FUNCTION fn_votos_positivos_curso -- SELECT fn_votos_positivos_curso(1)
(
	id_curso 	INT
)
RETURNS INT
DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(c.id_comentario)
							FROM	comentario c
							WHERE	c.id_curso = id_curso
                            AND		c.valoracion = 1
						)
						, 0)
					);
    
	RETURN (Cantidad);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_votos_negativos_curso;

DELIMITER //

CREATE FUNCTION fn_votos_negativos_curso -- SELECT fn_votos_negativos_curso(2)
(
	id_curso 	INT
)
RETURNS INT
DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(c.id_comentario)
							FROM	comentario c
							WHERE	c.id_curso = id_curso
                            AND		c.valoracion = 0
						)
						, 0)
					);
    
	RETURN (Cantidad);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_cantidad_ventas_curso;

DELIMITER //

CREATE FUNCTION fn_cantidad_ventas_curso -- SELECT fn_cantidad_ventas_curso(1)
(
	id_curso 	INT
)
RETURNS INT
DETERMINISTIC
BEGIN

	DECLARE Cantidad INT DEFAULT 0;
    SET Cantidad = 	(
						SELECT IFNULL((
							SELECT 	COUNT(v.id_venta)
							FROM	venta v
							WHERE	v.id_curso = id_curso
                            AND		(v.id_nivel_curso IS NULL OR v.id_nivel_curso <= 0)
						)
						, 0)
					);
    
	RETURN (Cantidad);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_cant_niveles_curso;

DELIMITER //

CREATE FUNCTION fn_cant_niveles_curso -- SELECT fn_cant_niveles_curso(2)
(
	id_curso 	INT
)
RETURNS INT
DETERMINISTIC
BEGIN

	DECLARE CantidadNiveles 			INT DEFAULT 0;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES POR CURSO
    SET CantidadNiveles =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_nivel_curso)
		FROM		nivel_curso nc
		WHERE 		nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_curso

	);
    
	RETURN (CantidadNiveles);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_cant_niveles_completados_usuario;

DELIMITER //

CREATE FUNCTION fn_cant_niveles_completados_usuario -- SELECT fn_cant_niveles_completados_usuario(2, 1)
(
	id_curso 	INT,
    id_usuario	INT
)
RETURNS INT
DETERMINISTIC
BEGIN

	DECLARE CantidadNivelesCompletados 	INT DEFAULT 0;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES COMPLETADOS POR CURSO Y USUARIO
    SET CantidadNivelesCompletados =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_historial_usuario)
		FROM		historial_usuario h
		INNER JOIN	nivel_curso nc
					ON h.id_nivel_curso = nc.id_nivel_curso
		WHERE 		h.id_usuario = id_usuario
					AND nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_completados

	);
    
	RETURN (CantidadNivelesCompletados);

END //

DELIMITER ;

DROP FUNCTION IF EXISTS fn_fecha_finalizacion_curso;

DELIMITER //

CREATE FUNCTION fn_fecha_finalizacion_curso -- SELECT fn_fecha_finalizacion_curso(2, 1)
(
	id_curso 	INT,
    id_usuario	INT
)
RETURNS DATETIME
DETERMINISTIC
BEGIN

	DECLARE CantidadNiveles 			INT DEFAULT 0;
	DECLARE CantidadNivelesCompletados 	INT DEFAULT 0;

	DECLARE FechaFinalizacion 			DATETIME DEFAULT NULL;
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES POR CURSO
    SET CantidadNiveles =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_nivel_curso)
		FROM		nivel_curso nc
		WHERE 		nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_curso

	);
    
    -- OBTENEMOS LA CANTIDAD DE NIVELES COMPLETADOS POR CURSO Y USUARIO
    SET CantidadNivelesCompletados =
    (
    
		SELECT IFNULL((
		
		SELECT		COUNT(id_historial_usuario)
		FROM		historial_usuario h
		INNER JOIN	nivel_curso nc
					ON h.id_nivel_curso = nc.id_nivel_curso
		WHERE 		h.id_usuario = id_usuario
					AND nc.id_curso = id_curso
		
		), 0)  AS cant_niveles_completados

	);
        
    -- SI LA CANTIDAD ES IGUAL ENTONCES TERMINO EL CURSO
    IF CantidadNiveles = CantidadNivelesCompletados THEN
    
		-- OBTENEMOS LA FECHA DE FINALIZACION
		SET FechaFinalizacion =
		(
		
			SELECT IFNULL((
			
			SELECT		h.fecha_alta
			FROM		historial_usuario h
			INNER JOIN	nivel_curso nc
						ON h.id_nivel_curso = nc.id_nivel_curso
			WHERE 		h.id_usuario = id_usuario
						AND nc.id_curso = id_curso
			ORDER BY	h.fecha_alta DESC
			LIMIT		1
			
			), NULL) AS fecha_finalizacion

		);
    
    END IF;
    
	RETURN (FechaFinalizacion);

END //

DELIMITER ;


-- --------------------------------------------------
-- VISTAS
-- --------------------------------------------------

DROP VIEW IF EXISTS v_cursos;

DELIMITER //

CREATE VIEW v_cursos -- SELECT * FROM v_cursos
AS

	SELECT		c.id_curso,
				c.id_usuario,
				c.titulo,
				c.subtitulo,
				c.descripcion,
				c.precio,
				c.activo,
				c.imagen,
				c.fecha_alta,
				c.fecha_mod,
				c.tipo_imagen,
                u.nick AS nick_usuario,
                fn_votos_positivos_curso(c.id_curso) AS votos_positivos,
                fn_votos_negativos_curso(c.id_curso) AS votos_negativos,
                fn_cantidad_ventas_curso(c.id_curso) AS cantidad_ventas
            
    FROM		curso c
                        
	INNER JOIN	usuario u
				ON c.id_usuario = u.id_usuario;

//

DELIMITER ;

DROP VIEW IF EXISTS v_curso_categoria;

DELIMITER //

CREATE VIEW v_curso_categoria -- SELECT * FROM v_curso_categoria
AS
	SELECT		cc.id_curso_categoria,
				cc.id_curso,
				cc.id_categoria,
				cc.fecha_alta,
				cc.fecha_mod,
				c.nombre AS categoria
                
	FROM		curso_categoria cc
                        
	INNER JOIN	categoria c
				ON cc.id_categoria = c.id_categoria;

//

DELIMITER ;

DROP VIEW IF EXISTS v_historial_usuario;

DELIMITER //

CREATE VIEW v_historial_usuario -- SELECT * FROM v_historial_usuario
AS
	SELECT		h.id_historial_usuario,
				h.id_usuario,
                c.id_curso,
                h.id_nivel_curso,
                u.nick AS nick_usuario,
                RTRIM(CONCAT(u.nombre, ' ', u.ap_paterno, ' ', u.ap_materno)) AS nombre_usuario,
                -- u.imagen AS imagen_usuario,
                -- u.tipo_imagen AS tipo_imagen_usuario,
                c.titulo AS curso,
                nc.titulo AS nivel_curso,
                -- c.imagen AS imagen_curso,
                -- c.tipo_imagen AS tipo_imagen_curso,
                h.fecha_alta,
                h.fecha_mod
                
	FROM		historial_usuario h
                        
	INNER JOIN	usuario u
				ON h.id_usuario = u.id_usuario
                        
	INNER JOIN	nivel_curso nc
				ON h.id_nivel_curso = nc.id_nivel_curso
                        
	INNER JOIN	curso c
				ON nc.id_curso = c.id_curso;

//

DELIMITER ;

DROP VIEW IF EXISTS v_venta;

DELIMITER //

CREATE VIEW v_venta -- SELECT * FROM v_venta
AS
	SELECT		v.id_venta,
				v.id_usuario,
                v.id_curso,
                v.id_nivel_curso,
                v.forma_pago,
                v.monto_pago,
                fn_fecha_finalizacion_curso(v.id_curso, v.id_usuario) AS fecha_finalizacion,
                u.nick AS nick_usuario,
                RTRIM(CONCAT(u.nombre, ' ', u.ap_paterno, ' ', u.ap_materno)) AS nombre_usuario,
                -- u.imagen AS imagen_usuario,
                -- u.tipo_imagen AS tipo_imagen_usuario,
                c.titulo AS curso,
                nc.titulo AS nivel_curso,
                -- c.imagen AS imagen_curso,
                -- c.tipo_imagen AS tipo_imagen_curso,
                v.fecha_alta,
                v.fecha_mod
                
	FROM		venta v
                        
	INNER JOIN	usuario u
				ON v.id_usuario = u.id_usuario
                        
	LEFT JOIN	nivel_curso nc
				ON v.id_nivel_curso = nc.id_nivel_curso
                        
	LEFT JOIN	curso c
				ON v.id_curso = c.id_curso;

//

DELIMITER ;

DROP VIEW IF EXISTS v_mensaje;

DELIMITER //

CREATE VIEW v_mensaje -- SELECT * FROM v_mensaje
AS
	SELECT		m.id_mensaje,
    
				m.id_usuario_rem,
				m.id_usuario_dest,
                
                u_rem.nick AS nick_usuario_rem,
                u_rem.imagen AS imagen_usuario_rem,
                u_rem.tipo_imagen AS tipo_imagen_usuario_rem,
                
                u_dest.nick AS nick_usuario_dest,
                u_dest.imagen AS imagen_usuario_dest,
                u_dest.tipo_imagen AS tipo_imagen_usuario_dest,
                
				m.mensaje,
				m.fecha_alta,
				m.fecha_mod
                
	FROM		mensaje m
                        
	INNER JOIN	usuario u_rem
				ON m.id_usuario_rem = u_rem.id_usuario
                        
	INNER JOIN	usuario u_dest
				ON m.id_usuario_dest = u_dest.id_usuario;

//

DELIMITER ;

DROP VIEW IF EXISTS v_comentario;

DELIMITER //

CREATE VIEW v_comentario -- SELECT * FROM v_comentario
AS
	SELECT		c.id_comentario,
				c.id_usuario,
                c.id_curso,
                c.comentario,
                c.valoracion,
                u.nick AS nick_usuario,
                RTRIM(CONCAT(u.nombre, ' ', u.ap_paterno, ' ', u.ap_materno)) AS nombre_usuario,
                u.imagen AS imagen_usuario,
                u.tipo_imagen AS tipo_imagen_usuario,
                c.fecha_alta,
                c.fecha_mod
                
	FROM		comentario c
                        
	INNER JOIN	usuario u
				ON c.id_usuario = u.id_usuario;

//

DELIMITER ;

-- --------------------------------------------------
-- CREACION DE SPs
-- --------------------------------------------------

-- TABLA [usuario]

DROP PROCEDURE IF EXISTS sp_usuario_create;
DROP PROCEDURE IF EXISTS sp_usuario_selectall;
DROP PROCEDURE IF EXISTS sp_usuario_select;
DROP PROCEDURE IF EXISTS sp_usuario_selectByNick;
DROP PROCEDURE IF EXISTS sp_usuario_passwordrepetida;
DROP PROCEDURE IF EXISTS sp_usuario_selectByEmail;
DROP PROCEDURE IF EXISTS sp_usuario_validate;
DROP PROCEDURE IF EXISTS sp_usuario_updateimage;
DROP PROCEDURE IF EXISTS sp_usuario_updatenombre;
DROP PROCEDURE IF EXISTS sp_usuario_updatepassword;

DELIMITER //

CREATE PROCEDURE sp_usuario_create -- CALL sp_usuario_create(1, 'asd', '123', 'asd@jotmail.com')
(
	IN p_id_rol		INT,
    IN p_nick		VARCHAR(50),
    IN p_password	VARCHAR(50),
    IN p_email		VARCHAR(100)
)
BEGIN

	INSERT INTO usuario (id_rol, 		nick, 		password, 		email) 
	VALUES 				(p_id_rol,		p_nick,		p_password,		p_email);
    
    SELECT IFNULL(MAX(id_usuario), 0) AS id FROM usuario;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_updateimage -- CALL sp_usuario_updateimage()
(
	IN p_id_usuario		INT,
	IN p_imagen			MEDIUMBLOB,
    IN p_tipo_imagen	VARCHAR(25)
)
BEGIN

	UPDATE			usuario
    SET				imagen = p_imagen,
					tipo_imagen = p_tipo_imagen
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_selectall -- CALL sp_usuario_selectall
(
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario as u;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_select -- CALL sp_usuario_select(:p_id_usuario)
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		id_usuario = p_id_usuario;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_selectByNick -- CALL sp_usuario_selectByNick('isolis')
(
	IN p_nick		VARCHAR(50)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		nick = p_nick;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_selectByEmail -- CALL sp_usuario_selectByEmail('iansolis98@outlook.com')
(
	IN p_email		VARCHAR(100)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		email = p_email;
	
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_passwordrepetida -- CALL sp_usuario_passwordrepetida(1, 'a1234567890A') -- DROP PROCEDURE IF EXISTS sp_usuario_passwordrepetida;
(
	IN p_id_usuario		INT,
    IN p_password 		VARCHAR(50)
)
BEGIN

	DECLARE Repetida BIT DEFAULT 0;
    SET Repetida = (SELECT EXISTS(SELECT id_usuario FROM usuario WHERE p_id_usuario = p_id_usuario AND password = p_password));
    
	SELECT Repetida AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_updatenombre -- CALL sp_usuario_updatenombre()
(
	IN p_id_usuario		INT,
    IN p_nombre			VARCHAR(300),
    IN p_ap_paterno		VARCHAR(50),
    IN p_ap_materno		VARCHAR(50)
)
BEGIN

	UPDATE			usuario
    SET				nombre = p_nombre,
					ap_paterno = p_ap_paterno,
                    ap_materno = p_ap_materno
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_updatepassword -- CALL sp_usuario_updatepassword()
(
	IN p_id_usuario		INT,
    IN p_password		VARCHAR(50)
)
BEGIN

	UPDATE			usuario
    SET				password = p_password
	WHERE			id_usuario = p_id_usuario;
    
    SELECT 			p_id_usuario;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_usuario_validate -- CALL sp_usuario_validate('isolis', 'a1234567890A')
(
	IN p_nick		VARCHAR(50),
    IN p_password	VARCHAR(50)
)
BEGIN

	SELECT		u.id_usuario,
				u.id_rol,
                u.email,
                u.nick,
                '' AS password,
                u.nombre,
                u.ap_paterno,
                u.ap_materno,
                u.imagen,
                u.fecha_alta,
                u.fecha_mod,
                u.tipo_imagen
    FROM		usuario AS u
    WHERE		u.nick = p_nick
				AND u.password = p_password;
	
END //

DELIMITER ;

-- TABLA [categoria]

DROP PROCEDURE IF EXISTS sp_categoria_create;
DROP PROCEDURE IF EXISTS sp_categoria_selectall;
DROP PROCEDURE IF EXISTS sp_categoria_select;
DROP PROCEDURE IF EXISTS sp_categoria_selectByNombre;
DROP PROCEDURE IF EXISTS sp_categoria_update;
DROP PROCEDURE IF EXISTS sp_categoria_delete;
DROP PROCEDURE IF EXISTS sp_categoria_existe;

DELIMITER //

CREATE PROCEDURE sp_categoria_create -- CALL sp_categoria_create
(
	IN p_nombre			VARCHAR(100)
)
BEGIN
		
		INSERT INTO 	categoria(nombre)
        VALUES			(
							p_nombre
						);
    
    SELECT IFNULL(MAX(id_categoria), 0) AS id FROM categoria;
        
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categoria_selectall -- CALL sp_categoria_selectall
(
)
BEGIN

	SELECT		
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categoria_select -- CALL sp_categoria_select
(
	IN p_id_categoria	INT
)
BEGIN

	SELECT
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria
	WHERE
						id_categoria = p_id_categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categoria_selectByNombre -- CALL sp_categoria_selectByNombre
(
	IN p_nombre	VARCHAR(100)
)
BEGIN

	SELECT
						id_categoria,
						nombre,
						fecha_alta,
						fecha_mod
	FROM		
						categoria
	WHERE
						nombre = p_nombre;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categoria_existe -- CALL sp_categoria_existe
(
	IN p_nombre			VARCHAR(100)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_categoria
							FROM		
									categoria
							WHERE
									nombre = p_nombre
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE sp_categoria_update -- CALL sp_categoria_update
(
	IN p_id_categoria	INT,
	IN p_nombre			VARCHAR(100)
)
BEGIN

	UPDATE
						categoria
	SET
						nombre 		= p_nombre,
                        fecha_mod 	= NOW()
	WHERE
						id_categoria = p_id_categoria;
						
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_categoria_delete -- CALL sp_categoria_delete
(
	IN p_id_categoria	INT
)
BEGIN

	DELETE FROM	
						categoria
	WHERE
						id_categoria = p_id_categoria;
    
END //

DELIMITER ;

-- TABLA [rol]

DROP PROCEDURE IF EXISTS sp_rol_create;
DROP PROCEDURE IF EXISTS sp_rol_selectall;
DROP PROCEDURE IF EXISTS sp_rol_select;
DROP PROCEDURE IF EXISTS sp_rol_update;
DROP PROCEDURE IF EXISTS sp_rol_delete;
DROP PROCEDURE IF EXISTS sp_rol_existe;

DELIMITER //

CREATE PROCEDURE sp_rol_create -- CALL sp_rol_create
(
	IN p_nombre			VARCHAR(50)
)
BEGIN

		INSERT INTO 	rol(nombre)
        VALUES			(
							p_nombre
						);
    
    SELECT IFNULL(MAX(id_rol), 0) AS id FROM rol;
                        
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_rol_selectall -- CALL sp_rol_selectall
(
)
BEGIN

	SELECT		
						id_rol,
						nombre
	FROM		
						rol;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_rol_select -- CALL sp_rol_select
(
	IN p_id_rol			INT
)
BEGIN

	SELECT		
						id_rol,
						nombre
	FROM		
						rol
	WHERE				
						id_rol = p_id_rol;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_rol_existe -- CALL sp_rol_existe
(
	IN p_nombre			VARCHAR(50)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT		
									id_rol
							FROM		
									rol
							WHERE				
									id_rol = p_id_rol
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_rol_update -- CALL sp_rol_update
(
	IN p_id_rol			INT,
	IN p_nombre			VARCHAR(50)
)
BEGIN

	UPDATE
						rol
	SET
						nombre 		= p_nombre
	WHERE
						id_rol = p_id_rol;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_rol_delete -- CALL sp_rol_delete
(
	IN p_id_rol			INT
)
BEGIN

	DELETE FROM	
						rol
	WHERE
						id_rol = p_id_rol;
		
END //

DELIMITER ;

-- TABLA [comentario]

DROP PROCEDURE IF EXISTS sp_comentario_create;
DROP PROCEDURE IF EXISTS sp_comentario_selectall;
DROP PROCEDURE IF EXISTS sp_comentario_selectallByCurso;
DROP PROCEDURE IF EXISTS sp_comentario_select;
DROP PROCEDURE IF EXISTS sp_comentario_update;
DROP PROCEDURE IF EXISTS sp_comentario_delete;
DROP PROCEDURE IF EXISTS sp_comentario_existe;

DELIMITER //

CREATE PROCEDURE sp_comentario_create -- CALL sp_comentario_create
(
	IN p_id_curso		INT,
    IN p_id_usuario		INT,
    IN p_comentario		VARCHAR(1000),
    IN p_valoracion		INT
)
BEGIN
		
		INSERT INTO 	comentario(id_curso, id_usuario, comentario, valoracion)
        VALUES			(
							p_id_curso,
                            p_id_usuario,
                            p_comentario,
                            p_valoracion
						);
    
    SELECT IFNULL(MAX(id_comentario), 0) AS id FROM comentario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_selectall -- CALL sp_comentario_selectall
(
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_selectallByCurso -- CALL sp_comentario_selectallByCurso(2);
(
	IN p_id_curso INT
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario
                        
	WHERE				id_curso = p_id_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_select -- CALL sp_comentario_select
(
	IN p_id_comentario	INT
)
BEGIN

	SELECT		
						id_comentario,
						id_usuario,
						id_curso,
						comentario,
                        valoracion,
                        nick_usuario,
                        nombre_usuario,
                        imagen_usuario,
                        tipo_imagen_usuario,
						fecha_alta,
						fecha_mod
	FROM		
						v_comentario
	WHERE
						id_comentario = p_id_comentario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_existe -- CALL sp_comentario_existe
(
	IN p_id_usuario		INT,
    IN p_id_curso		INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_comentario
							FROM		
									comentario
							WHERE
									id_usuario = p_id_usuario
                                    AND id_curso = p_id_curso
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_update -- CALL sp_comentario_update
(
	IN p_id_comentario	INT,
    IN p_comentario		VARCHAR(1000),
    IN p_valoracion		INT
)
BEGIN

	UPDATE
						comentario
	SET
						comentario 		= p_comentario,
                        valoracion		= p_valoracion,
                        fecha_mod 		= NOW()
	WHERE
						id_comentario = p_id_comentario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_comentario_delete -- CALL sp_comentario_delete
(
	IN p_id_comentario	INT
)
BEGIN

	DELETE FROM	
						comentario
	WHERE
						id_comentario = p_id_comentario;
		
END //

DELIMITER ;

-- TABLA [curso]

DROP PROCEDURE IF EXISTS sp_curso_create;
DROP PROCEDURE IF EXISTS sp_curso_selectall;
DROP PROCEDURE IF EXISTS sp_curso_selectallByIdUsuario;
DROP PROCEDURE IF EXISTS sp_curso_selectallAdquiridoByUsuario;
DROP PROCEDURE IF EXISTS sp_curso_selectallMasVendidos;
DROP PROCEDURE IF EXISTS sp_curso_selectallPopulares;
DROP PROCEDURE IF EXISTS sp_curso_selectallRecientes;
DROP PROCEDURE IF EXISTS sp_curso_selectallFiltro;
DROP PROCEDURE IF EXISTS sp_curso_select;
DROP PROCEDURE IF EXISTS sp_curso_selectByTitulo;
DROP PROCEDURE IF EXISTS sp_curso_update;
DROP PROCEDURE IF EXISTS sp_curso_updateImage;
DROP PROCEDURE IF EXISTS sp_curso_delete;
DROP PROCEDURE IF EXISTS sp_curso_existe;

DELIMITER //

CREATE PROCEDURE sp_curso_create -- CALL sp_curso_create
(
	IN p_id_usuario		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL(18, 2)
)
BEGIN
		
		INSERT INTO 	curso(id_usuario, titulo, subtitulo, descripcion, precio)
        VALUES			(
							p_id_usuario,
                            p_titulo,
                            p_subtitulo,
                            p_descripcion,
                            p_precio
						);
    
    SELECT IFNULL(MAX(id_curso), 0) AS id FROM curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectallAdquiridoByUsuario -- CALL sp_curso_selectallAdquiridoByUsuario(2)
(
	IN p_id_usuario	INT
)
BEGIN

	SELECT		
						c.id_curso,
						c.id_usuario,
                        c.titulo,
                        c.subtitulo,
                        c.descripcion,
                        c.precio,
                        c.activo,
                        c.imagen,
						c.fecha_alta,
						c.fecha_mod,
                        c.tipo_imagen,
                        c.nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos c
                        
	INNER JOIN			venta v
						ON v.id_curso = c.id_curso
                        
	WHERE				v.id_usuario = p_id_usuario;
                        
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectall -- CALL sp_curso_selectall
(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectallRecientes -- CALL sp_curso_selectallRecientes
(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY			fecha_alta DESC;
		
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE sp_curso_selectallByIdUsuario -- CALL sp_curso_selectallByIdUsuario(1)
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
					
	WHERE
						id_usuario = p_id_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectallMasVendidos -- CALL sp_curso_selectallMasVendidos
(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY
						cantidad_ventas DESC;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectallPopulares -- CALL sp_curso_selectallPopulares
(
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
                        
	ORDER BY			votos_positivos DESC;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_selectallFiltro -- CALL sp_curso_selectallFiltro('', )
(
	IN p_titulo				VARCHAR(100),
    IN p_id_categoria		INT,
    IN p_nick_autor			VARCHAR(100)
)
BEGIN

	SELECT	DISTINCT	v.id_curso,
						v.id_usuario,
                        v.titulo,
                        v.subtitulo,
                        v.descripcion,
                        v.precio,
                        v.activo,
                        v.imagen,
						v.fecha_alta,
						v.fecha_mod,
                        v.tipo_imagen,
                        v.nick_usuario,
                        v.votos_positivos,
                        v.votos_negativos,
                        v.cantidad_ventas
	FROM		
						v_cursos v
                        
	LEFT JOIN			curso_categoria cc
						ON v.id_curso = cc.id_curso
                        
	WHERE				
						(v.titulo LIKE CONCAT('%', p_titulo, '%')
                        OR v.nick_usuario LIKE CONCAT('%', p_nick_autor, '%'))
                        AND cc.id_categoria = p_id_categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_select -- CALL sp_curso_select
(
	IN p_id_curso		INT
)
BEGIN

	SELECT		
						id_curso,
						id_usuario,
                        titulo,
                        subtitulo,
                        descripcion,
                        precio,
                        activo,
                        imagen,
						fecha_alta,
						fecha_mod,
                        tipo_imagen,
                        nick_usuario,
                        votos_positivos,
                        votos_negativos,
                        cantidad_ventas
	FROM		
						v_cursos
	WHERE
						id_curso = p_id_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_existe -- CALL sp_curso_existe (1, 'Introducción a C# 32')
(
	IN p_id_usuario		INT,
	IN p_titulo			VARCHAR(100)
)
BEGIN
    
	SELECT fn_existe_curso(p_id_usuario, p_titulo) AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_update -- CALL sp_curso_update
(
	IN p_id_curso		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL(18, 2)
)
BEGIN

	UPDATE
						curso
	SET
						titulo 		= p_titulo,
						subtitulo 	= p_subtitulo,
						descripcion = p_descripcion,
						precio		= p_precio,
                        fecha_mod 	= NOW()
	WHERE
						id_curso = p_id_curso;
		
	SELECT				p_id_curso;
        
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_updateimage -- CALL sp_curso_updateimage()
(
	IN p_id_curso		INT,
	IN p_imagen			MEDIUMBLOB,
    IN p_tipo_imagen	VARCHAR(25)
)
BEGIN

	UPDATE			curso
    SET				imagen = p_imagen,
					tipo_imagen = p_tipo_imagen
	WHERE			id_curso = p_id_curso;
    
    SELECT 			p_id_curso;
    
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_delete -- CALL sp_curso_delete
(
	IN p_id_curso		INT
)
BEGIN

	UPDATE
						curso
	SET
						Activo 		= 0
	WHERE
						id_curso = p_id_curso;
		
END //

DELIMITER ;

-- TABLA [curso_categoria]

DROP PROCEDURE IF EXISTS sp_curso_categoria_create;
DROP PROCEDURE IF EXISTS sp_curso_categoria_selectall;
DROP PROCEDURE IF EXISTS sp_curso_categoria_selectallByCurso;
DROP PROCEDURE IF EXISTS sp_curso_categoria_select;
DROP PROCEDURE IF EXISTS sp_curso_categoria_update;
DROP PROCEDURE IF EXISTS sp_curso_categoria_delete;
DROP PROCEDURE IF EXISTS sp_curso_categoria_existe;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_create -- CALL sp_curso_categoria_create
(
	IN p_id_curso		INT,
    IN p_id_categoria	INT
)
BEGIN
		
		INSERT INTO 	curso_categoria(id_curso, id_categoria)
        VALUES			(
							p_id_curso,
                            p_id_categoria
						);
    
    SELECT IFNULL(MAX(id_curso_categoria), 0) AS id FROM curso_categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_selectall -- CALL sp_curso_categoria_selectall
(
)
BEGIN

	SELECT		
						cc.id_curso_categoria,
						cc.id_curso,
                        cc.id_categoria,
						cc.fecha_alta,
						cc.fecha_mod,
						cc.categoria
	FROM		
						v_curso_categoria cc;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_selectallByCurso -- CALL sp_curso_categoria_selectallByCurso(8)
(
	IN p_id_curso	INT
)
BEGIN

	SELECT		
						cc.id_curso_categoria,
						cc.id_curso,
                        cc.id_categoria,
						cc.fecha_alta,
						cc.fecha_mod,
                        cc.categoria
	FROM		
						v_curso_categoria cc
                        
	WHERE				
						cc.id_curso = p_id_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_select -- CALL sp_curso_categoria_select
(
	IN p_id_curso_categoria	INT
)
BEGIN

	SELECT		
						id_curso_categoria,
						id_curso,
                        id_categoria,
						fecha_alta,
						fecha_mod
	FROM		
						curso_categoria
	WHERE
						id_curso_categoria = p_id_curso_categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_existe -- CALL sp_curso_categoria_existe
(
	IN p_id_curso			INT,
    IN p_id_categoria		INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_curso_categoria
							FROM		
									curso_categoria
							WHERE
									id_curso = p_id_curso
                                    AND id_categoria = p_id_categoria
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_update -- CALL sp_curso_categoria_update
(
	IN p_id_curso_categoria	INT,
	IN p_id_curso		INT,
    IN p_id_categoria	INT
)
BEGIN

	UPDATE
						curso_categoria
	SET
						id_curso 		= p_id_curso,
                        id_categoria 	= p_id_categoria,
                        fecha_mod 		= NOW()
	WHERE
						id_curso_categoria = p_id_curso_categoria;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_categoria_delete -- CALL sp_curso_categoria_delete
(
	IN p_id_curso_categoria	INT
)
BEGIN

	DELETE FROM	
						curso_categoria
	WHERE
						id_curso_categoria = p_id_curso_categoria;
                        
	SELECT 				p_id_curso_categoria;
		
END //

DELIMITER ;

-- TABLA [historial_usuario]

DROP PROCEDURE IF EXISTS sp_historial_usuario_create;
DROP PROCEDURE IF EXISTS sp_historial_usuario_selectall;
DROP PROCEDURE IF EXISTS sp_historial_usuario_select;
DROP PROCEDURE IF EXISTS sp_historial_usuario_reporte;
DROP PROCEDURE IF EXISTS sp_historial_usuario_update;
DROP PROCEDURE IF EXISTS sp_historial_usuario_delete;
DROP PROCEDURE IF EXISTS sp_historial_usuario_existe;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_create -- CALL sp_historial_usuario_create
(
	IN p_id_usuario		INT,
    IN p_id_nivel_curso	INT
)
BEGIN
		
		INSERT INTO 	historial_usuario(id_usuario, id_nivel_curso)
        VALUES			(
							p_id_usuario,
                            p_id_nivel_curso
						);
    
    SELECT IFNULL(MAX(id_historial_usuario), 0) AS id FROM historial_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_selectall -- CALL sp_historial_usuario_selectall
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						h.id_historial_usuario,
						h.id_usuario,
						h.id_curso,
						h.id_nivel_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						h.nivel_curso,
						h.fecha_alta,
						h.fecha_mod
	FROM		
						v_historial_usuario h;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_select -- CALL sp_historial_usuario_select
(
	IN p_id_historial_usuario	INT
)
BEGIN

	SELECT		
						h.id_historial_usuario,
						h.id_usuario,
						h.id_curso,
						h.id_nivel_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						h.nivel_curso,
						h.fecha_alta,
						h.fecha_mod
	FROM		
						v_historial_usuario h
	WHERE
						h.id_historial_usuario = p_id_historial_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_reporte -- CALL sp_historial_usuario_reporte(1)
(
	IN p_id_usuario	INT
)
BEGIN

	SELECT				h.id_usuario,
						h.id_curso,
						h.nick_usuario,
						h.nombre_usuario,
						h.curso,
						fn_cant_niveles_completados_usuario(h.id_curso, h.id_usuario) AS cant_niveles_completados,
                        fn_cant_niveles_curso(h.id_curso) AS cant_niveles_curso,
                        (fn_cant_niveles_completados_usuario(h.id_curso, h.id_usuario) / fn_cant_niveles_curso(h.id_curso)) * 100 AS porcentaje_completado,
                        fn_fecha_finalizacion_curso(h.id_curso, h.id_usuario) AS fecha_finalizacion
	FROM		
						v_historial_usuario h
	WHERE
						h.id_usuario = p_id_usuario
	
    GROUP BY			h.curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_existe -- CALL sp_historial_usuario_existe
(
	IN p_id_usuario		INT,
    IN p_id_nivel_curso INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_historial_usuario
							FROM		
									historial_usuario
							WHERE
									id_usuario = p_id_usuario
                                    AND id_nivel_curso = p_id_nivel_curso
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_update -- CALL sp_historial_usuario_update
(
	IN p_id_usuario		INT,
    IN p_id_nivel_curso INT
)
BEGIN

	UPDATE
						historial_usuario
	SET
						id_usuario		= p_id_usuario,
                        id_nivel_curso 	= p_id_nivel_curso,
                        fecha_mod 	= NOW()
	WHERE
						id_categoria = p_id_categoria;
                        
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_delete -- CALL sp_historial_usuario_delete
(
	IN p_id_historial_usuario	INT
)
BEGIN

	DELETE FROM	
						historial_usuario
	WHERE
						id_historial_usuario = p_id_historial_usuario;
		
END //

DELIMITER ;

-- TABLA [mensaje]

DROP PROCEDURE IF EXISTS sp_mensaje_create;
DROP PROCEDURE IF EXISTS sp_mensaje_selectall;
DROP PROCEDURE IF EXISTS sp_mensaje_select;
DROP PROCEDURE IF EXISTS sp_mensaje_select;
DROP PROCEDURE IF EXISTS sp_mensaje_update;
DROP PROCEDURE IF EXISTS sp_mensaje_delete;
DROP PROCEDURE IF EXISTS sp_mensaje_existe;

DELIMITER //

CREATE PROCEDURE sp_mensaje_create -- CALL sp_mensaje_create
(
	IN p_id_usuario_rem		INT,
    IN p_id_usuario_dest 	INT,
    IN p_mensaje			VARCHAR(1000)
)
BEGIN
		
		INSERT INTO 	mensaje(id_usuario_rem, id_usuario_dest, mensaje)
        VALUES			(
							p_id_usuario_rem,
                            p_id_usuario_dest,
							p_mensaje
						);
    
    SELECT IFNULL(MAX(id_mensaje), 0) AS id FROM mensaje;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_selectall -- CALL sp_mensaje_selectall(4, 4)
(
	IN p_id_usuario_dest	INT,
    IN p_id_usuario_rem		INT
)
BEGIN

	IF p_id_usuario_dest = p_id_usuario_rem THEN

		SELECT		
					m.id_mensaje,
		
					m.id_usuario_rem,
					m.id_usuario_dest,
					
					m.nick_usuario_rem,
					m.imagen_usuario_rem,
					m.tipo_imagen_usuario_rem,
					
					m.nick_usuario_dest,
					m.imagen_usuario_dest,
					m.tipo_imagen_usuario_dest,
					
					m.mensaje,
					m.fecha_alta,
					m.fecha_mod
		FROM		
					v_mensaje m
							
		WHERE
					id_usuario_rem IN (p_id_usuario_rem, p_id_usuario_dest)
                    OR id_usuario_dest IN (p_id_usuario_dest, p_id_usuario_rem)
			
		ORDER BY	m.fecha_alta ASC;
    
    ELSE

		SELECT		
					m.id_mensaje,
		
					m.id_usuario_rem,
					m.id_usuario_dest,
					
					m.nick_usuario_rem,
					m.imagen_usuario_rem,
					m.tipo_imagen_usuario_rem,
					
					m.nick_usuario_dest,
					m.imagen_usuario_dest,
					m.tipo_imagen_usuario_dest,
					
					m.mensaje,
					m.fecha_alta,
					m.fecha_mod
		FROM		
					v_mensaje m
							
		WHERE
					(id_usuario_rem = p_id_usuario_rem OR id_usuario_rem = p_id_usuario_dest)
					AND (id_usuario_dest = p_id_usuario_dest OR id_usuario_dest = p_id_usuario_rem)
			
		ORDER BY	m.fecha_alta ASC;
    
    END IF;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_select -- CALL sp_mensaje_select
(
	IN p_id_mensaje 	INT
)
BEGIN

	SELECT		
				m.id_mensaje,
    
				m.id_usuario_rem,
				m.id_usuario_dest,
				
				m.nick_usuario_rem,
				m.imagen_usuario_rem,
				m.tipo_imagen_usuario_rem,
				
				m.nick_usuario_dest,
				m.imagen_usuario_dest,
				m.tipo_imagen_usuario_dest,
				
				m.mensaje,
				m.fecha_alta,
				m.fecha_mod
	FROM		
				v_mensaje m
	WHERE
						id_mensaje = p_id_mensaje;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_existe -- CALL sp_mensaje_existe
(
	IN p_id_mensaje 	INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_mensaje
							FROM		
									mensaje
							WHERE
									id_mensaje = p_id_mensaje
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_update -- CALL sp_mensaje_update
(
	IN p_id_mensaje		INT,
    IN p_mensaje		VARCHAR(1000)
)
BEGIN

	UPDATE
						mensaje
	SET
                        mensaje		= p_mensaje,
                        fecha_mod 	= NOW()
	WHERE
						id_mensaje = p_id_mensaje;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_delete -- CALL sp_mensaje_delete
(
	IN p_id_mensaje		INT
)
BEGIN

	DELETE FROM	
						mensaje
	WHERE
						id_mensaje = p_id_mensaje;
		
END //

DELIMITER ;

-- TABLA [multimedia_nivel]

DROP PROCEDURE IF EXISTS sp_multimedia_nivel_create;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_selectall;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_select;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_selectFirstVideo;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_update;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_delete;
DROP PROCEDURE IF EXISTS sp_multimedia_nivel_existe;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_create -- CALL sp_multimedia_nivel_create
(
	IN p_id_nivel_curso		INT,
    IN p_ruta				VARCHAR(500),
    IN p_nombre				VARCHAR(100),
    IN p_extension			VARCHAR(25),
    IN p_tipo				VARCHAR(250)
)
BEGIN
		
		INSERT INTO 	multimedia_nivel(id_nivel_curso, ruta, nombre, extension, tipo)
        VALUES			(
							p_id_nivel_curso,
                            p_ruta,
                            p_nombre,
                            p_extension,
                            p_tipo
						);
    
    SELECT IFNULL(MAX(id_multimedia_nivel), 0) AS id FROM multimedia_nivel;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_selectall -- CALL sp_multimedia_nivel_selectall (6)
(
	IN p_id_nivel_curso INT
)
BEGIN

	SELECT		
						id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
                        
	WHERE				
						id_nivel_curso = p_id_nivel_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_select -- CALL sp_multimedia_nivel_select (1);
(
	IN p_id_multimedia_nivel	INT
)
BEGIN

	SELECT		
						id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
	WHERE				
						id_multimedia_nivel = p_id_multimedia_nivel;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_selectFirstVideo -- CALL sp_multimedia_nivel_selectFirstVideo (2);
(
	IN p_id_nivel_curso	INT
)
BEGIN

	SELECT				id_multimedia_nivel,
						id_nivel_curso,
                        ruta,
                        nombre,
                        extension,
                        tipo,
						fecha_alta,
						fecha_mod
	FROM		
						multimedia_nivel
	WHERE				
						id_nivel_curso = p_id_nivel_curso
						AND tipo IN ('video/mp4', 'ogv', 'webm', 'flv')
                        
	ORDER BY			fecha_alta ASC
    
    LIMIT				1;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_existe -- CALL sp_multimedia_nivel_existe(7, 'PlanXboxXSeries.xlsx')
(
	IN p_id_nivel_curso	INT,
    IN p_nombre			VARCHAR(100)
)
BEGIN

	SELECT fn_existe_archivo_nivel(p_id_nivel_curso, p_nombre) AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_update -- CALL sp_multimedia_nivel_update
(
	IN p_id_multimedia_nivel INT,
    IN p_ruta				VARCHAR(500),
    IN p_nombre				VARCHAR(100),
    IN p_extension			VARCHAR(25),
    IN p_tipo				VARCHAR(50)
)
BEGIN

	UPDATE
						multimedia_nivel
	SET
						ruta 		= p_ruta,
                        nombre 		= p_nombre,
                        extension 	= p_extension,
                        tipo		= p_tipo,
                        fecha_mod 	= NOW()
	WHERE
						id_multimedia_nivel = p_id_multimedia_nivel;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_delete -- CALL sp_multimedia_nivel_delete
(
	IN p_id_multimedia_nivel INT
)
BEGIN

	DELETE FROM	
						multimedia_nivel
	WHERE
						id_multimedia_nivel = p_id_multimedia_nivel;
                        
	SELECT 				p_id_multimedia_nivel;
		
END //

DELIMITER ;

-- TABLA [nivel_curso]

DROP PROCEDURE IF EXISTS sp_nivel_curso_create;
DROP PROCEDURE IF EXISTS sp_nivel_curso_selectall;
DROP PROCEDURE IF EXISTS sp_nivel_curso_select;
DROP PROCEDURE IF EXISTS sp_nivel_curso_update;
DROP PROCEDURE IF EXISTS sp_nivel_curso_delete;
DROP PROCEDURE IF EXISTS sp_nivel_curso_existe;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_create -- CALL sp_nivel_curso_create
(
	IN p_id_curso		INT,
    IN p_orden			INT,
    IN p_precio			DECIMAL(18,2),
    IN p_titulo			VARCHAR(100),
    IN p_descripcion	VARCHAR(1000)
)
BEGIN
		
		INSERT INTO 	nivel_curso(id_curso, orden, precio, titulo, descripcion)
        VALUES			(
							p_id_curso,
                            p_orden,
                            p_precio,
                            p_titulo,
                            p_descripcion
						);
    
    SELECT IFNULL(MAX(id_nivel_curso), 0) AS id FROM nivel_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_selectall -- CALL sp_nivel_curso_selectall(8)
(
	IN p_id_curso INT
)
BEGIN

	SELECT		
						id_nivel_curso,
						id_curso,
						orden,
                        precio,
                        titulo,
                        descripcion,
						fecha_alta,
						fecha_mod
	FROM		
						nivel_curso
	WHERE				
						id_curso = p_id_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_select -- CALL sp_nivel_curso_select
(
	IN p_id_nivel_curso	INT
)
BEGIN

	SELECT		
						id_nivel_curso,
						id_curso,
						orden,
                        precio,
                        titulo,
                        descripcion,
						fecha_alta,
						fecha_mod
	FROM		
						nivel_curso
	WHERE				
						id_nivel_curso = p_id_nivel_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_existe -- CALL sp_nivel_curso_existe (8, 'Introducción al lenguaje')
(
	IN p_id_curso	INT,
    IN p_titulo		VARCHAR(100)	
)
BEGIN

	SELECT fn_existe_nivel_curso(p_id_curso, p_titulo) AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_update -- CALL sp_nivel_curso_update
(
	IN p_id_nivel_curso	INT,
    IN p_orden			INT,
    IN p_precio			DECIMAL(18,2),
    IN p_titulo			VARCHAR(100),
    IN p_descripcion	VARCHAR(1000)
)
BEGIN

	UPDATE
						nivel_curso
	SET
						orden		= p_orden,
                        precio 		= p_precio,
                        titulo		= p_titulo,
                        descripcion = p_descripcion,
                        fecha_mod 	= NOW()
	WHERE
						id_nivel_curso = p_id_nivel_curso;
                        
	SELECT				p_id_nivel_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_delete -- CALL sp_nivel_curso_delete
(
	IN p_id_nivel_curso	INT
)
BEGIN

	DELETE FROM	
						nivel_curso
	WHERE
						id_nivel_curso = p_id_nivel_curso;
                        
	SELECT				p_id_nivel_curso;
		
END //

DELIMITER ;

-- TABLA [venta]

DROP PROCEDURE IF EXISTS sp_venta_create;
DROP PROCEDURE IF EXISTS sp_venta_selectall;
DROP PROCEDURE IF EXISTS sp_venta_select;
DROP PROCEDURE IF EXISTS sp_venta_reporte;
DROP PROCEDURE IF EXISTS sp_venta_ganancia;
DROP PROCEDURE IF EXISTS sp_venta_update;
DROP PROCEDURE IF EXISTS sp_venta_delete;
DROP PROCEDURE IF EXISTS sp_venta_existe;

DELIMITER //

CREATE PROCEDURE sp_venta_create -- CALL sp_venta_create
(
	IN p_id_curso		INT,
	IN p_id_nivel_curso	INT,
    IN p_id_usuario		INT,
    IN p_forma_pago		INT
)
BEGIN

	IF p_id_nivel_curso <= 0 THEN
		
		INSERT INTO 	venta(id_curso, id_nivel_curso, id_usuario, forma_pago, monto_pago)
        VALUES			(
							p_id_curso,
                            p_id_nivel_curso,
                            p_id_usuario,
                            p_forma_pago,
                            fn_precio_curso(1, p_id_curso)
						);
    ELSE
		
		INSERT INTO 	venta(id_curso, id_nivel_curso, id_usuario, forma_pago, monto_pago)
        VALUES			(
							p_id_curso,
                            p_id_nivel_curso,
                            p_id_usuario,
                            p_forma_pago,
                            fn_precio_curso(2, p_id_nivel_curso)
						);
                        
    END IF;
    
    SELECT IFNULL(MAX(id_venta), 0) AS id FROM venta;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_selectall -- CALL sp_venta_selectall(3)
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT		
						v.id_venta,
						v.id_usuario,
						v.id_curso,
						v.id_nivel_curso,
						v.forma_pago,
						v.monto_pago,
						v.fecha_finalizacion,
						v.nick_usuario,
						v.nombre_usuario,
						v.curso,
						v.nivel_curso,
						v.fecha_alta,
						v.fecha_mod
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario
    
    ORDER BY			V.fecha_alta DESC;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_reporte -- CALL sp_venta_reporte(3)
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT				v.curso,
                        COUNT(v.id_usuario) AS cantidad_alumnos,
                        COUNT(v.id_curso) 	AS cantidad_ventas,
                        SUM(v.monto_pago) 	AS total_curso
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario
                        
	GROUP BY			v.curso
    
    ORDER BY			v.fecha_alta DESC;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_ganancia -- CALL sp_venta_ganancia(1)
(
	IN p_id_usuario		INT
)
BEGIN

	SELECT				IFNULL(SUM(v.monto_pago), 0) AS ganancia
	FROM		
						v_venta v
                        
	LEFT JOIN			curso c
						ON c.id_curso = v.id_curso
                        
	WHERE				c.id_usuario = p_id_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_select -- CALL sp_venta_select
(
	IN p_id_venta		INT
)
BEGIN

	SELECT		
						v.id_venta,
						v.id_usuario,
						v.id_curso,
						v.id_nivel_curso,
						v.forma_pago,
						v.monto_pago,
						v.fecha_finalizacion,
						v.nick_usuario,
						v.nombre_usuario,
						v.curso,
						v.nivel_curso,
						v.fecha_alta,
						v.fecha_mod
	FROM		
						v_venta v
	WHERE				
						id_venta = p_id_venta;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_existe -- CALL sp_venta_existe (2, 2, 0)
(
	IN p_id_usuario		INT,
    IN p_id_curso		INT,
    IN p_id_nivel_curso	INT
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_venta
							FROM		
									venta
							WHERE
									id_usuario = p_id_usuario
									AND ((id_curso > 0 AND id_curso = p_id_curso) OR (id_nivel_curso > 0 AND id_nivel_curso = p_id_nivel_curso))
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_update -- CALL sp_venta_update
(
	IN p_id_venta			INT,
    IN p_id_usuario			INT,
    IN p_fecha_finalizacion	DATETIME
)
BEGIN

	UPDATE
						venta
	SET
                        fecha_finalizacion 	= p_fecha_finalizacion,
                        fecha_mod 			= NOW()
	WHERE
						id_venta = p_id_venta
                        AND id_usuario = p_id_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_delete -- CALL sp_venta_delete
(
)
BEGIN
		
END //

DELIMITER ;


-- --------------------------------------------------
-- INSERTS INICIALES
-- --------------------------------------------------

# tabla: rol
INSERT INTO rol (nombre) VALUES ('Creador');
INSERT INTO rol (nombre) VALUES ('Alumno');

# tabla: usuario

INSERT INTO usuario (id_rol, 		nick, 		password, 		email) 
VALUES 				(1,				'naisroan',	'a1234567890A',	'naisroan@outlook.com');

INSERT INTO usuario (id_rol, 		nick, 		password, 		email) 
VALUES 				(2,				'isolis',	'a1234567890A', 'iansolis98@outlook.com');
