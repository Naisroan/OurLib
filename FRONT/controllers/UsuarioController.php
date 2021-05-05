<?php

    require_once ('../code/StoredProcedure.php');
    require_once ('../model/Usuario.php');

    define("AUTH_NAME", "auth_user");

    $action = null;
    $data = null;

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

    switch ($action) {

        case 'create': {

            echo create(json_decode($data));
            exit();
        }

        case 'getAll': {

            echo getAll();
            exit();
        }

        case 'getById': {

            echo getById($data);
            exit();
        }

        case 'getByNick': {

            echo getByNick($data);
            exit();
        }

        case 'getByEmail': {

            echo getByEmail($data);
            exit();
        }

        case 'validate': {

            echo validate(json_decode($data));
            exit();
        }

        case 'login': {

            login(json_decode($data));
            exit();
        }

        case 'logout': {

            logout();
            exit();
        }

        case 'getLoggedUser': {
            echo getLoggedUser();
            exit();
        };

        case 'updateImage': {

            echo updateImage();
            exit();
        }

        case 'refreshLoggedUser': {

            echo refreshLoggedUser();
            exit();
        };

        case 'updateNombre': {

            echo updateNombre(json_decode($data));
            exit();
        }

        case 'updatePassword': {

            echo updatePassword(json_decode($data));
            exit();
        }

        header('HTTP/1.0 500 Internal Server Error');
        die("Funcionalidad no controlada");
        exit();
    }

    function getAll() {

        $sp = new SP("sp_usuario_selectall");
        $result = $sp->select();

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return json_encode(Usuario::parseArrayToList($result));
    }

    function getById($id) {

        $sp = new SP("sp_usuario_select");
        $result = $sp->select($id);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        $usuario = Usuario::parse($result[0]);
        $usuarioJson = json_encode($usuario);
        return $usuarioJson;
    }

    function getByNick($name) {

        $sp = new SP("sp_usuario_selectByNick");
        $result = $sp->select($name);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        $usuario = Usuario::parse($result[0]);
        $usuarioJson = json_encode($usuario);
        return $usuarioJson;
    }

    function getByEmail($email) {

        $sp = new SP("sp_usuario_selectByEmail");
        $result = $sp->select($email);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        $usuario = Usuario::parse($result[0]);
        $usuarioJson = json_encode($usuario);
        return $usuarioJson;
    }

    function create($nodo) {

        $sp = new SP("sp_usuario_create");
        $result = $sp->insertOrUpdate($nodo->id_rol, $nodo->nick, $nodo->password, $nodo->email);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return $result;
    }

    function validate($nodo) {

        $sp = new SP("sp_usuario_validate");
        $result = $sp->select($nodo->nick, $nodo->password);

        if(!$sp->isSuccess()) {

            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        $usuario = Usuario::parse($result[0]);
        $usuarioJson = json_encode($usuario);
        return $usuarioJson;
    }

    function login($nodo) {

        if (!isset($_SESSION)) {
            session_start();
        }

        $_SESSION[AUTH_NAME] = $nodo;

        return true;
    }

    function logout() {

        if (!isset($_SESSION)) {
            session_start();
        }

        unset($_SESSION[AUTH_NAME]);
    }

    function updateImage() {

        if (!isset($_FILES['nodo'])) {

            header('HTTP/1.0 500 Internal Server Error');
            die("No se ha podido obtener la información de la imagen");
        }
        
        $usuarioLogeado = json_decode(getLoggedUser());
        $file = $_FILES['nodo'];
        $ruta = $file['tmp_name'];
        $tipo = $file['type'];
        $imageBlob = file_get_contents($ruta);

        $sp = new SP("sp_usuario_updateimage");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $imageBlob, $tipo);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return true;
    }

    function getLoggedUser() {

        if (!isset($_SESSION)) {
            session_start();
        }

        return json_encode(isset($_SESSION[AUTH_NAME]) ? $_SESSION[AUTH_NAME] : "");
    }

    function refreshLoggedUser() {

        if (!isset($_SESSION)) {
            session_start();
        }

        $usuarioLogeado = $_SESSION[AUTH_NAME];
        $_SESSION[AUTH_NAME] = json_decode(getById($usuarioLogeado->id_usuario));
        $usuarioLogeado = $_SESSION[AUTH_NAME];

        return getLoggedUser();
    }

    function updateNombre($nodo) {

        $usuarioLogeado = json_decode(getLoggedUser());

        $sp = new SP("sp_usuario_updatenombre");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $nodo->nombre, $nodo->ap_paterno, $nodo->ap_materno);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return true;
    }

    function updatePassword($nodo) {

        $usuarioLogeado = json_decode(getLoggedUser());
        $usuarioValidate = validate((object)array("nick" => $usuarioLogeado->nick, "password" => $nodo->actual));

        if ($usuarioValidate == null) {

            header('HTTP/1.0 500 Internal Server Error');
            die("La contraseña no coincide con la actual");
        }

        $sp = new SP("sp_usuario_updatepassword");
        $result = $sp->insertOrUpdate($usuarioLogeado->id_usuario, $nodo->new);

        if(!$sp->isSuccess()) {
            
            header('HTTP/1.0 500 Internal Server Error');
            die($sp->errorMessage);
        }

        return true;
    }
?>