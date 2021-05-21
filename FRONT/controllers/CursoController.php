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

        // curso

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
            break;
        }

        case "getAllByUsuarioLogeado": {
            echo getAllByUsuarioLogeado();
            break;
        }

        case "getAllByAdquiridoByUsuario": {
            echo getAllByAdquiridoByUsuario();
            break;
        }

        case "getAllFiltro": {
            echo getAllFiltro(json_decode($data));
            break;
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

        // nivel

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

        case "getAllRecientes": {
            echo getAllRecientes();
            break;
        }

        case "getAllMasVendidos": {
            echo getAllMasVendidos();
            break;
        }

        case "getAllPopulares": {
            echo getAllPopulares();
            break;
        }

        case "deleteNivelCurso": {
            echo deleteNivelCurso($data);
            break;
        }

        // nivel - archivo
        case "createArchivoNivel": {
            echo createArchivoNivel(json_decode($_POST["data"]));
            break;
        }

        case "getByFirstVideo": {
            echo getByFirstVideo($data);
            break;
        }

        case "existsArchivoNivel": {
            echo existsArchivoNivel(json_decode($_POST["data"]));
            break;
        }

        case "getAllArchivoNivelByNivel": {
            echo getAllArchivoNivelByNivel($data);
            break;
        }

        case "deleteArchivoNivel": {
            echo deleteArchivoNivel($data);
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

    function getAllByUsuarioLogeado() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            return "[]";
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_curso_selectallByIdUsuario");
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

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllByAdquiridoByUsuario() {

        $usuarioLogeado = getLoggedUser();

        if ($usuarioLogeado == null || $usuarioLogeado == "" || $usuarioLogeado == "{}") {
            return "[]";
        }

        $usuarioLogeado = json_decode($usuarioLogeado);

        $sp = new SP("sp_curso_selectallAdquiridoByUsuario");
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

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllRecientes() {

        $sp = new SP("sp_curso_selectallRecientes");
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

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllMasVendidos() {

        $sp = new SP("sp_curso_selectallMasVendidos");
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

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllPopulares() {

        $sp = new SP("sp_curso_selectallPopulares");
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

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function getAllFiltro($nodo) {

        $sp = new SP("sp_curso_selectallFiltro");
        $result = $sp->select($nodo->titulo, $nodo->id_categoria, $nodo->autor);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = Curso::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

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

    // --------------------------------------------------
    // NIVEL
    // --------------------------------------------------

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

    // --------------------------------------------------
    // NIVEL - ARCHIVO
    // --------------------------------------------------

    function createArchivoNivel($nodo) {

        // obtenemos informacion del archivo
        $file = $_FILES['nodo'];

        // deslogamos la info
        $nombre = $file['name'];
        $rutaTemporal = $file['tmp_name'];
        $tipo = $file['type'];
        $extension = pathinfo($nombre, PATHINFO_EXTENSION);

        // verificamos si existe
        $sp = new SP("sp_multimedia_nivel_existe");
        $result = $sp->select($nodo->id_nivel_curso, $nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if ($result[0][0]) {
            header('HTTP/1.0 500 Internal Server Error');
            die("El archivo ya existe, si desea actualizarlo, retirelo y vuelvalo a subir");
        }

        // creamos la carpeta donde estará el archivo
        $directoryFilepath = createDirectoryForFile($nodo->id_curso, $nodo->id_nivel_curso);
        $filePath = $directoryFilepath . "\\" . $nombre;

        // insertamos en bd
        $sp = new SP("sp_multimedia_nivel_create");
        $result = $sp->insertOrUpdate($nodo->id_nivel_curso, $filePath, $nombre, $extension, $tipo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        // movemos el archivo
        if (!move_uploaded_file($rutaTemporal, $filePath)) {
            return false;
        }

        return $result;
    }

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

    function getByFirstVideo($id_nivel_curso) {

        $sp = new SP("sp_multimedia_nivel_selectFirstVideo");
        $result = $sp->select($id_nivel_curso);

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

    function existsArchivoNivel($nodo) {

        // obtenemos informacion del archivo
        $file = $_FILES['nodo'];

        // deslogamos la info
        $nombre = $file['name'];
        $rutaTemporal = $file['tmp_name'];
        $tipo = $file['type'];
        $extension = pathinfo($nombre, PATHINFO_EXTENSION);

        // ejecutamos sp
        $sp = new SP("sp_multimedia_nivel_existe");
        $result = $sp->select($nodo->id_nivel_curso, $nombre);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result[0][0];
    }

    function getAllArchivoNivelByNivel($id_nivel_curso) {

        $sp = new SP("sp_multimedia_nivel_selectall");
        $result = $sp->select($id_nivel_curso);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $list = array();

        foreach ($result as &$key) {

            $nodo = ArchivoNivel::parse($key);
            $list[] = $nodo;
        }

        $json = json_encode($list);

        return $json;
    }

    function deleteArchivoNivel($id_multimedia_nivel) {

        // primero borramos el archivo de blobs
        $nodo = getArchivoNivel($id_multimedia_nivel);

        if ($nodo == null || $nodo == "" || $nodo == "{}") {
            header('HTTP/1.0 500 Internal Server Error');
            die("El archivo no existe");
        }

        $nodo = json_decode($nodo);

        if (!unlink($nodo->ruta)) {
            header('HTTP/1.0 500 Internal Server Error');
            die("No se pudo eliminar el archivo");
        }

        // ahora lo borramos de la bd
        $sp = new SP("sp_multimedia_nivel_delete");
        $result = $sp->insertOrUpdate($id_multimedia_nivel);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }
?>