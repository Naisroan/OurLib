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

        case "exists": {
            echo exists($data);
            break;
        }

        case "getAll": {
        }

        case "update": {
            echo update(json_decode($data));
            break;
        }

        case 'updateImage': {

            echo updateImage();
            break;
        }

        case "delete": {
            break;
        }

        case "createNivelCurso": {
            echo createNivelCurso(json_decode($data));
            break;
        }

        case "getNivelCurso": {
            echo getNivelCurso($data);
            break;
        }

        case "existsNivelCurso": {
            echo existsNivelCurso(json_decode($data));
            break;
        }

        case "updateNivelCurso": {
            echo updateNivelCurso(json_decode($data));
            break;
        }

        case "getAllNivelByCurso": {
            echo getAllNivelByCurso($data);
            break;
        }

        case "deleteNivelCurso": {
            echo deleteNivelCurso($data);
            break;
        }
    }

    exit();

    function create($nodo) {

        $usuarioLogeado = json_decode(getLoggedUser());
        $sp = new SP("sp_curso_create");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $nodo->titulo, $nodo->subtitulo, $nodo->descripcion, $nodo->precio);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function update($nodo) {

        $sp = new SP("sp_curso_update");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->titulo, $nodo->subtitulo, $nodo->descripcion, $nodo->precio);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function updateImage() {

        if (!isset($_POST['id_curso'])) {

            header('HTTP/1.0 500 Internal Server Error');
            die("No se ha podido obtener la información del curso");
        }

        if (!isset($_FILES['nodo'])) {

            header('HTTP/1.0 500 Internal Server Error');
            die("No se ha podido obtener la información de la imagen");
        }
        
        $id_curso = $_POST['id_curso'];
        $file = $_FILES['nodo'];
        $ruta = $file['tmp_name'];
        $tipo = $file['type'];
        $imageBlob = file_get_contents($ruta);

        $sp = new SP("sp_curso_updateimage");
        $result = $sp->insertOrUpdate($id_curso, $imageBlob, $tipo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return true;
    }

    function get($id) {

        $sp = new SP("sp_curso_select");
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

    function exists($titulo) {

        $usuarioLogeado = json_decode(getLoggedUser());
        $sp = new SP("sp_curso_existe");
        $result = $sp->select($usuarioLogeado->id_usuario, $titulo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function createNivelCurso($nodo) {

        $sp = new SP("sp_nivel_curso_create");
        $result = $sp->insertOrUpdate($nodo->id_curso, $nodo->orden, $nodo->precio, $nodo->titulo, $nodo->descripcion);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function getNivelCurso($id) {

        $sp = new SP("sp_nivel_curso_select");
        $result = $sp->select($id);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $nodo = NivelCurso::parse($result[0]);
        $json = json_encode($nodo);

        return $json;
    }

    function existsNivelCurso($nodo) {

        $sp = new SP("sp_nivel_curso_existe");
        $result = $sp->select($nodo->id_curso, $nodo->titulo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function updateNivelCurso($nodo) {

        $sp = new SP("sp_nivel_curso_update");
        $result = $sp->insertOrUpdate($nodo->id_nivel_curso, $nodo->orden, $nodo->precio, $nodo->titulo, $nodo->descripcion);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function getAllNivelByCurso($id_curso) {

        $sp = new SP("sp_nivel_curso_selectall");
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

            $nodo = NivelCurso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function deleteNivelCurso($id_nivel_curso) {

        $sp = new SP("sp_nivel_curso_delete");
        $result = $sp->insertOrUpdate($id_nivel_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }
?>