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

        case "getAllByUsuarioDestinatario": {
            echo getAllByUsuarioDestinatario($data);
            break;
        }

        case "exists": {
            echo "";
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

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe crear una cuenta o iniciar sesión para comprar un curso");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_mensaje_create");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $nodo->id_usuario_dest, $nodo->mensaje);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function getAll() {

        $sp = new SP("");
        $result = $sp->select();

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = Mensaje::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllByUsuarioDestinatario($id_usuario_dest) {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe crear una cuenta o iniciar sesión para obtener los mensajes");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_mensaje_selectall");
        $result = $sp->select($id_usuario_dest, $usuarioLogeado->id_usuario);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = Mensaje::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }
?>