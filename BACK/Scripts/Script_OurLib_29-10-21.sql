DELIMITER //
USE bisonteca;
//
DELIMITER ;

DELIMITER //
CREATE TABLE IF NOT EXISTS parametro
(
	id_parametro		INT PRIMARY KEY AUTO_INCREMENT,
    nombre				VARCHAR(50) NOT NULL,
    valor				VARCHAR(1000) NOT NULL,
    fecha_alta			DATETIME NOT NULL DEFAULT NOW(),
    fecha_mod			DATETIME NOT NULL DEFAULT NOW()
);
//
DELIMITER ;

DELIMITER //
TRUNCATE TABLE parametro; //
DELIMITER ;

DELIMITER //
INSERT INTO parametro (nombre, valor)
VALUES
(
	-- nombre
    'NOMBRE_APP',
    -- valor
    'OurLib'
);
INSERT INTO parametro (nombre, valor)
VALUES
(
	-- nombre
    'NOMBRE_CLIENTE',
    -- valor
    'Empresa Ficticia'
);
//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS `?`; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `?`()
BEGIN
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;
	ALTER TABLE `usuario` ADD COLUMN `id_rol_especial` INT NOT NULL DEFAULT 0;
END //
DELIMITER ;

DELIMITER //
CALL `?`();
DROP PROCEDURE `?`; //
DELIMITER ;

DELIMITER //
UPDATE usuario SET id_rol_especial = 1 WHERE id_usuario = 1; //
DELIMITER ;

DELIMITER //
DROP PROCEDURE `sp_usuario_validate`; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_usuario_validate`(
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
                u.tipo_imagen,
                u.id_rol_especial
    FROM		usuario AS u
    WHERE		u.nick = p_nick
				AND u.password = p_password;
	
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE `sp_usuario_selectall`; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_usuario_selectall`(
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
                u.tipo_imagen,
                u.id_rol_especial
    FROM		usuario as u;
	
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_usuario_updateIdRol`; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_usuario_updateIdRol`(
	IN p_id_usuario	INT,
	IN p_id_rol 	INT
)
BEGIN

	UPDATE	usuario
    SET		id_rol = p_id_rol
    WHERE	id_usuario = p_id_usuario;
    
    SELECT 	p_id_usuario;
	
END //
DELIMITER ;