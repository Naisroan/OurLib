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
            echo create($data);
            break;
        }

        case "get": {
            echo "";
            break;
        }

        case "getAll": {
            echo getAll();
            break;
        }

        case "getReporte": {
            echo getReporte();
            break;
        }

        case "exists": {
            echo exists($data);
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

    function create($id_nivel_curso) {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        if (exists($id_nivel_curso)) {
            return true;
        }

        $sp = new SP("sp_historial_usuario_create");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $id_nivel_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }
    
    function exists($id_nivel_curso) {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para verificar el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_historial_usuario_existe");
        $result = $sp->select($usuarioLogeado->id_usuario, $id_nivel_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function getAll() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_historial_usuario_selectall");
        $result = $sp->select($usuarioLogeado->id_usuario);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = HistorialUsuario::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getReporte() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_historial_usuario_reporte");
        $result = $sp->select($usuarioLogeado->id_usuario);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = HistorialUsuarioReporte::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }
?>