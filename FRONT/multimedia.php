<?php

    require_once ('code/StoredProcedure.php');
    require_once ('model/ArchivoNivel.php');

    // define("PATH_BLOBS", dirname(__FILE__, 2) . '\blobs');

    // $parsed_url = parse_url($_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
    $id_multimedia_nivel = isset($_GET["id"]) ? $_GET["id"] : 0;

    if ($id_multimedia_nivel <= 0) {
        die("El identificador del archivo multimedia no es valido");
    }

    $nodo = getArchivoNivel($id_multimedia_nivel);

    if ($nodo == null || $nodo == "" || $nodo == "{}") {
        die("El archivo multimedia no existe");
    }

    $nodo = json_decode($nodo);
    
    // header("Cache-Control: public");
    // header("Content-Description: File Transfer");
    header("Content-Disposition: attachment; filename=" . $nodo->nombre);
    header("Content-Type: " . $nodo->tipo);
    // header("Content-Transfer-Encoding: binary");

    if(!file_exists($nodo->ruta)) {
        die("El archivo multimedia esta registrado pero no se ha encontrado, es posible que se haya eliminado");
    }

    readfile($nodo->ruta);

    exit();

    function getArchivoNivel($id_multimedia_nivel) {

        $sp = new SP("sp_multimedia_nivel_select");
        $result = $sp->select($id_multimedia_nivel);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = ArchivoNivel::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }
?>