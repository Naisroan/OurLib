DELIMITER //
USE ourlib;
//

DELIMITER //
DROP TABLE IF EXISTS FolioPase;
//

DELIMITER //
CREATE TABLE foliopase
(
	id_foliopase		INT AUTO_INCREMENT PRIMARY KEY,
    id_curso			INT NOT NULL,
    folio				VARCHAR(50) NOT NULL,
    activo				BIT NOT NULL,
    fecha_vigencia		DATETIME NOT NULL,
    fecha_alta			DATETIME NOT NULL,
    fecha_mod			DATETIME NULL,
    FOREIGN KEY 		(`id_curso`) REFERENCES `curso` (`id_curso`)
);
//

DELIMITER //
DROP FUNCTION IF EXISTS `fn_generar_foliopase`
//

DELIMITER //
CREATE FUNCTION `fn_generar_foliopase`(
	p_id_curso 			INT,
    p_fecha_vigencia	DATETIME
) RETURNS VARCHAR(50)
    DETERMINISTIC
BEGIN

	DECLARE id_folio_pase_max INT;
    DECLARE Folio VARCHAR(50);
    
    SET id_folio_pase_max = (SELECT IFNULL(MAX(id_foliopase), 0) FROM foliopase) + 1;
    SET Folio = CONCAT
				(
					id_folio_pase_max,
					p_id_curso,
					DATE_FORMAT(p_fecha_vigencia, '%Y%m'),
                    DATE_FORMAT(NOW(), '%Y%m')
				);
    
	RETURN (Folio);

END
//

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_create`;
//

DELIMITER //
CREATE PROCEDURE sp_foliopase_create
(
	IN p_id_curso			INT,
    IN p_fecha_vigencia		DATETIME
)
BEGIN

	INSERT INTO foliopase (id_curso, folio, activo, fecha_vigencia, fecha_alta, fecha_mod)
    VALUES
    (
		p_id_curso,
        fn_generar_foliopase(p_id_curso, p_fecha_vigencia),
        1,
        p_fecha_vigencia,
        NOW(),
        NOW()
    );

    SELECT IFNULL(MAX(id_foliopase), 0) AS id FROM foliopase;
    
END
//

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_selectall`;
//

DELIMITER //
CREATE PROCEDURE sp_foliopase_selectall
(
	IN p_id_curso			INT
)
BEGIN

	SELECT		f.id_foliopase,
				f.id_curso,
				f.folio,
                f.activo,
                f.fecha_vigencia,
                f.fecha_alta,
                f.fecha_mod
	
    FROM		foliopase f
    
    WHERE		f.id_curso = p_id_curso;

END
//

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_select`;
//

DELIMITER //
CREATE PROCEDURE sp_foliopase_select
(
	IN p_id_foliopase			INT
)
BEGIN

	SELECT		f.id_foliopase,
				f.id_curso,
				f.folio,
                f.activo,
                f.fecha_vigencia,
                f.fecha_alta,
                f.fecha_mod
	
    FROM		foliopase f
    
    WHERE		f.id_foliopase = p_id_foliopase;

END
//

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_update`;
//

DELIMITER //
CREATE PROCEDURE `sp_foliopase_update`(
	IN p_id_foliopase	INT,
	IN p_fecha_vigencia	DATETIME,
    IN p_activo			BIT
)
BEGIN

	UPDATE		foliopase
	SET			fecha_vigencia 	= p_fecha_vigencia,
				activo			= p_activo,
				fecha_mod 		= NOW()
	WHERE		id_foliopase 	= p_id_foliopase;
    
    SELECT p_id_foliopase;
		
END
//

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_delete`;
//

DELIMITER //
CREATE PROCEDURE `sp_foliopase_delete`(
	IN p_id_foliopase	INT
)
BEGIN

	DELETE FROM	
						foliopase
	WHERE
						id_foliopase = p_id_foliopase;
                        
	SELECT				p_id_foliopase;
		
END //

DELIMITER //
DROP PROCEDURE IF EXISTS `sp_foliopase_selectByFolio`;
//

DELIMITER //
CREATE PROCEDURE sp_foliopase_selectByFolio
(
	IN p_folio	VARCHAR(50)
)
BEGIN

	SELECT		f.id_foliopase,
				f.id_curso,
				f.folio,
                f.activo,
                f.fecha_vigencia,
                f.fecha_alta,
                f.fecha_mod
	
    FROM		foliopase f
    
    WHERE		f.folio = p_folio;

END
//