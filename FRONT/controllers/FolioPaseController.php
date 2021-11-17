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

            echo get($data);
            break;
        }

        case "getByFolio": {

            echo getByFolio($data);
            break;
        }

        case "getAll": {
            echo getAll($data);
            break;
        }

        case "update": {
            echo update(json_decode($data));
            break;
        }

        case "delete": {
            echo delete($data);
            break;
        }
    }

    exit();

    function create($nodo) {

        $sp = new SP("sp_foliopase_create");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->fecha_vigencia);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function update($nodo) {

        $sp = new SP("sp_foliopase_update");
        $result = $sp->insertOrUpdate($nodo->id_foliopase, $nodo->fecha_vigencia, $nodo->activo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function delete($id_foliopase) {

        $sp = new SP("sp_foliopase_delete");
        $result = $sp->insertOrUpdate($id_foliopase);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function get($id) {

        $sp = new SP("sp_foliopase_select");
        $result = $sp->select($id);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = FolioPase::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }

    function getByFolio($folio) {

        $sp = new SP("sp_foliopase_selectByFolio");
        $result = $sp->select($folio);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = FolioPase::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }

    function getAll($id_curso) {

        $sp = new SP("sp_foliopase_selectall");
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

            $nodo = FolioPase::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }
?>