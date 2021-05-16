<?php

    // conexion sql
    require_once ('StoredProcedure.php');

    // entidades
    require_once ('../model/Usuario.php');
    require_once ('../model/Curso.php');
    require_once ('../model/Categoria.php');
    require_once ('../model/CursoCategoria.php');
    require_once ('../model/NivelCurso.php');
    require_once ('../model/ArchivoNivel.php');
    require_once ('../model/Comentario.php');

    // constantes
    define("AUTH_NAME", "auth_user");
    define("PATH_BLOBS", dirname(__FILE__, 2) . '\blobs');

    // variables globales
    $action = null;
    $data = null;

    // validacion de accion e información
    if (isset($_POST["action"])) {

        $action = isset($_POST['action']) ? $_POST['action'] : null;
        $data = isset($_POST['nodo']) ? $_POST['nodo'] : null;

    } else if (isset($_FILES['action'])) {

        $action = isset($_FILES['action']) ? $_FILES['action'] : null;
        $data = isset($_FILES['nodo']) ? $_FILES['nodo'] : null;

    } else {

        header('HTTP/1.0 500 Internal Server Error');
        die("Funcionalidad no controlada");
        exit();
    }

    function getLoggedUser() {

        if (!isset($_SESSION)) {
            session_start();
        }

        return json_encode(isset($_SESSION[AUTH_NAME]) ? $_SESSION[AUTH_NAME] : "");
    }

    function createDirectoryForFile($id_curso, $id_nivel_curso) {

        $path = PATH_BLOBS . '\\curso_' . $id_curso . '\\nivel_' . $id_nivel_curso;

        if (!is_dir($path)) {
            mkdir($path, 0777, true);
        }

        return $path;
    }
?>