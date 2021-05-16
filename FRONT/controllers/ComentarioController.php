<?php

    // middleware
    require_once ('../code/Middleware.php');

    // verificacion de accion
    switch($action) {

        default: {
            header('HTTP/1.0 500 Internal Server Error');
            die("Funcionalidad no controlada");
            exit();
            break;
        }

        case "create": {
            echo create(json_decode($data));
            break;
        }

        case "get": {
            echo "";
            break;
        }

        case "exists": {
            echo exists(json_decode($data));
            break;
        }

        case "getAllByCurso": {
            echo getAllByCurso($data);
            break;
        }

        case "update": {
            echo "";
            break;
        }

        case "delete": {
            echo "";
            break;
        }
    }

    exit();

    function create($nodo) {

        $usuarioLogeado = json_decode(getLoggedUser());
        $sp = new SP("sp_comentario_create");
        $result = $sp->insertOrUpdate($nodo->id_curso, $usuarioLogeado->id_usuario, $nodo->comentario, $nodo->valoracion);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function exists($nodo) {

        $usuarioLogeado = json_decode(getLoggedUser());
        $sp = new SP("sp_comentario_existe");
        $result = $sp->select($usuarioLogeado->id_usuario, $nodo->id_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function getAllByCurso($id_curso) {

        $sp = new SP("sp_comentario_selectallByCurso");
        $result = $sp->select($id_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = Comentario::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }
?>