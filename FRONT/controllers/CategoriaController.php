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

        case "getByNombre": {

            echo getByNombre($data);
            break;
        }

        case "exists": {
            echo exists($data);
            break;
        }

        case "createCursoCategoria": {
            echo agregarCategoriaCurso(json_decode($data));
            break;
        }

        case "existsCursoCategoria": {
            echo existsCategoriaCurso(json_decode($data));
            break;
        }

        case "getAll": {
            echo getAll();
            break;
        }

        case "getAllCursoCategoriaByCurso": {
            echo getAllCursoCategoriaByCurso($data);
            break;
        }

        case "update": {
            echo update(json_decode($data));
            break;
        }

        case "deleteCursoCategoria": {
            echo deleteCursoCateogria($data);
            break;
        }

        case "delete": {
            break;
        }
    }

    exit();

    function create($nodo) {

        $sp = new SP("sp_categoria_create");
        $result = $sp->insertOrUpdate($nodo->nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function exists($nombre) {

        $sp = new SP("sp_categoria_existe");
        $result = $sp->select($nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function agregarCategoriaCurso($nodo) {

        $sp = new SP("sp_curso_categoria_create");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->id_categoria);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function existsCategoriaCurso($nodo) {

        $sp = new SP("sp_curso_categoria_existe");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->id_categoria);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function update($nodo) {

        $sp = new SP("sp_categoria_update");
        $result = $sp->insertOrUpdate($nodo->id_categoria, $nodo->nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
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

        $sp = new SP("sp_categoria_selectall");
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

            $nodo = Categoria::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllCursoCategoriaByCurso($id_curso) {

        $sp = new SP("sp_curso_categoria_selectallByCurso");
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

            $nodo = CursoCategoria::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getByNombre($nombre) {

        $sp = new SP("sp_categoria_selectByNombre");
        $result = $sp->select($nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = Categoria::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }

    function deleteCursoCateogria($id_curso_categoria) {

        $sp = new SP("sp_curso_categoria_delete");
        $result = $sp->insertOrUpdate($id_curso_categoria);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }
?>