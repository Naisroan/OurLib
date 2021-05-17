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
    precio				DECIMAL NOT NULL,
    activo				BIT NOT NULL DEFAULT 1,
    imagen				MEDIUMBLOB NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

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
    precio				DECIMAL,
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
    tipo				VARCHAR(50) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW(),
    
    CONSTRAINT 			FK_multimedia_nivel_nivel_curso FOREIGN KEY (id_nivel_curso) REFERENCES nivel_curso(id_nivel_curso)
);

CREATE TABLE venta
(
	id_venta			INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario			INT NOT NULL,
    id_curso			INT NOT NULL, -- se puede comprar un nivel
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
						id_curso,
						id_usuario,
                        valoracion,
						fecha_alta,
						fecha_mod
	FROM		
						comentario;
		
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
						id_curso,
						id_usuario,
                        valoracion,
						fecha_alta,
						fecha_mod
	FROM		
						comentario
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
DROP PROCEDURE IF EXISTS sp_curso_select;
DROP PROCEDURE IF EXISTS sp_curso_update;
DROP PROCEDURE IF EXISTS sp_curso_delete;
DROP PROCEDURE IF EXISTS sp_curso_existe;

DELIMITER //

CREATE PROCEDURE sp_curso_create -- CALL sp_curso_create
(
	IN p_id_usuario		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL
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
                        imagen,
						fecha_alta,
						fecha_mod
	FROM		
						curso;
		
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
                        imagen,
						fecha_alta,
						fecha_mod
	FROM		
						curso
	WHERE
						id_curso = p_id_curso;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_existe -- CALL sp_curso_existe
(
	IN p_titulo			VARCHAR(100)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_curso
							FROM		
									curso
							WHERE
									titulo = p_titulo
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_curso_update -- CALL sp_curso_update
(
	IN p_id_curso		INT,
	IN p_titulo			VARCHAR(100),
	IN p_subtitulo		VARCHAR(250),
	IN p_descripcion 	VARCHAR(1000),
	IN p_precio 		DECIMAL
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
						id_curso_categoria,
						id_curso,
                        id_categoria,
						fecha_alta,
						fecha_mod
	FROM		
						curso_categoria;
		
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
		
END //

DELIMITER ;

-- TABLA [historial_usuario]

DROP PROCEDURE IF EXISTS sp_historial_usuario_create;
DROP PROCEDURE IF EXISTS sp_historial_usuario_selectall;
DROP PROCEDURE IF EXISTS sp_historial_usuario_select;
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
)
BEGIN

	SELECT		
						id_historial_usuario,
						id_usuario,
                        id_nivel_curso,
						fecha_alta,
						fecha_mod
	FROM		
						historial_usuario;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_historial_usuario_select -- CALL sp_historial_usuario_select
(
	IN p_id_historial_usuario	INT
)
BEGIN

	SELECT		
						id_historial_usuario,
						id_usuario,
                        id_nivel_curso,
						fecha_alta,
						fecha_mod
	FROM		
						historial_usuario
	WHERE
						id_historial_usuario = p_id_historial_usuario;
		
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
DROP PROCEDURE IF EXISTS sp_mensaje_update;
DROP PROCEDURE IF EXISTS sp_mensaje_delete;
DROP PROCEDURE IF EXISTS sp_mensaje_existe;

DELIMITER //

CREATE PROCEDURE sp_mensaje_create -- CALL sp_mensaje_create
(
	IN p_id_usuario_rem	INT,
    IN p_id_usuario_dest INT,
    IN p_mensaje		VARCHAR(1000)
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

CREATE PROCEDURE sp_mensaje_selectall -- CALL sp_mensaje_selectall
(
)
BEGIN

	SELECT		
						id_mensaje,
						id_usuario_rem,
						id_usuario_dest,
                        mensaje,
						fecha_alta,
						fecha_mod
	FROM		
						mensaje;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_mensaje_select -- CALL sp_mensaje_select
(
	IN p_id_mensaje 	INT
)
BEGIN

	SELECT		
						id_mensaje,
						id_usuario_rem,
						id_usuario_dest,
                        mensaje,
						fecha_alta,
						fecha_mod
	FROM		
						mensaje
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
    IN p_tipo				VARCHAR(50)
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

CREATE PROCEDURE sp_multimedia_nivel_selectall -- CALL sp_multimedia_nivel_selectall
(
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
						multimedia_nivel;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_multimedia_nivel_select -- CALL sp_multimedia_nivel_select
(
	IN id_multimedia_nivel	INT
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

CREATE PROCEDURE sp_multimedia_nivel_existe -- CALL sp_multimedia_nivel_existe
(
	IN p_id_nivel_curso	INT,
    IN p_ruta			VARCHAR(500),	
    IN p_nombre			VARCHAR(100),
    IN p_extension		VARCHAR(25),
    IN p_tipo			VARCHAR(50)
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_multimedia_nivel
							FROM		
									multimedia_nivel
							WHERE
									id_nivel_curso = p_id_nivel_curso
                                    AND ruta = p_ruta 
                                    AND nombre = p_nombre
                                    AND extension = p_extension
                                    AND tipo = p_tipo
                        )
					);
    
	SELECT Existe AS Resultado;
		
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
    IN p_precio			DECIMAL,
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

CREATE PROCEDURE sp_nivel_curso_selectall -- CALL sp_nivel_curso_selectall
(
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
						nivel_curso;
		
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

CREATE PROCEDURE sp_nivel_curso_existe -- CALL sp_nivel_curso_existe
(
	IN p_id_curso	INT,
    IN p_titulo		VARCHAR(100)	
)
BEGIN

	DECLARE Existe BIT DEFAULT 0;
    SET Existe = 	(
						SELECT EXISTS
                        (
							SELECT
									id_nivel_curso
							FROM		
									nivel_curso
							WHERE
									id_curso = p_id_curso
                                    AND titulo = p_titulo
                        )
					);
    
	SELECT Existe AS Resultado;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_nivel_curso_update -- CALL sp_nivel_curso_update
(
	IN p_id_nivel_curso	INT,
    IN p_orden			INT,
    IN p_precio			DECIMAL,
    IN p_titulo			VARCHAR(100),
    IN p_descripcion	VARCHAR(1000)
)
BEGIN

	UPDATE
						nivel_curso
	SET
						nombre 		= p_nombre,
                        orden		= p_orden,
                        precio 		= p_precio,
                        titulo		= p_titulo,
                        descripcion = p_descripcion,
                        fecha_mod 	= NOW()
	WHERE
						id_nivel_curso = p_id_nivel_curso;
		
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
		
END //

DELIMITER ;

-- TABLA [venta]

DROP PROCEDURE IF EXISTS sp_venta_create;
DROP PROCEDURE IF EXISTS sp_venta_selectall;
DROP PROCEDURE IF EXISTS sp_venta_select;
DROP PROCEDURE IF EXISTS sp_venta_update;
DROP PROCEDURE IF EXISTS sp_venta_delete;
DROP PROCEDURE IF EXISTS sp_venta_existe;

DELIMITER //

CREATE PROCEDURE sp_venta_create -- CALL sp_venta_create
(
	IN p_id_curso		INT,
    IN p_id_usuario		INT,
    IN p_forma_pago		INT
)
BEGIN
		
		INSERT INTO 	venta(id_curso, id_usuario, forma_pago)
        VALUES			(
							p_id_curso,
                            p_id_usuario,
                            p_forma_pago
						);
    
    SELECT IFNULL(MAX(id_venta), 0) AS id FROM venta;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_selectall -- CALL sp_venta_selectall
(
)
BEGIN

	SELECT		
						id_venta,
						id_usuario,
						id_curso,
                        forma_pago,
                        fecha_finalizacion,
						fecha_alta,
						fecha_mod
	FROM		
						venta;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_select -- CALL sp_venta_select
(
	IN p_id_venta		INT
)
BEGIN

	SELECT		
						id_venta,
						id_usuario,
						id_curso,
                        forma_pago,
                        fecha_finalizacion,
						fecha_alta,
						fecha_mod
	FROM		
						venta
	WHERE				
						id_venta = p_id_venta;
		
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_venta_existe -- CALL sp_venta_existe
(
	IN p_id_usuario		INT,
    IN p_id_curso		INT,
    IN p_forma_pago		INT
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
									AND id_curso = p_id_curso
                                    AND forma_pago = p_forma_pago
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
