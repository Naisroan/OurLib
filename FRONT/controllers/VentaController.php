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

        case "getAll": {
            echo getAll();
            break;
        }

        case "getAllReporte": {
            echo getAllReporte();
            break;
        }

        case "getGanancia": {
            echo getGanancia();
            break;
        }

        case "getByNombre": {
            echo "";
            break;
        }

        case "exists": {
            echo exists(json_decode($data));
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

        $sp = new SP("sp_venta_create");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->id_nivel_curso, $usuarioLogeado->id_usuario, $nodo->forma_pago);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function exists($nodo) {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe crear una cuenta o iniciar sesión para comprar un curso");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_venta_existe");
        $result = $sp->select($usuarioLogeado->id_usuario, $nodo->id_curso, $nodo->id_nivel_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function get($id) {

        $sp = new SP("sp_categoria_select");
        $result = $sp->select($id);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = Curso::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }

    function getAll() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_venta_selectall");
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

            $nodo = Venta::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllReporte() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_venta_reporte");
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

            $nodo = VentaReporte::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getGanancia() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("Debe tener la sesión iniciado para crear el historial");
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_venta_ganancia");
        $result = $sp->select($usuarioLogeado->id_usuario);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        return $result[0][0];
    }
?>