<?php

    # AjaxRequests.php

    require_once ('StoredProcedure.php');
    require_once ('../model/Usuario.php');

    if (isset($_POST['action']) && !empty($_POST['action'])) {

        $action = $_POST['action'];
        $data = $_POST['nodo'];

        switch ($action) {

            case 'getUsers': {

                echo getUsers();
                break;
            }

            case 'getUser': {

                echo getUser($data);
                break;
            }

            case 'getUserByNick': {

                echo getUserByNick($data);
                break;
            }

            case 'getUserByEmail': {

                echo getUserByEmail($data);
                break;
            }

            case 'createUser': {

                $id = createUser(json_decode($data));
                echo $id;

                break;
            }

            case 'validateUser': {

                echo validateUser(json_decode($data));
                break;
            }

            case 'loginUser': {

                loginUser(json_decode($data));
                break;
            }

            case 'logout': {

                logout();
                break;
            }

            default: {
                echo 'ACTION_EMPTY';
                break;
            }
        }
    }

    // MODELO: Usuario.php

    function getUsers() {

        $sp = new SP("sp_usuario_selectall");
        $result = $sp->select();

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        return json_encode(Usuario::parseArrayToList($result));
    }

    function getUser($id) {

        $sp = new SP("sp_usuario_select");
        $result = $sp->select($id);

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        if (count($result) <= 0) {
            return null;
        }

        return json_encode(Usuario::parse($result[0]));
    }

    function getUserByNick($name) {

        $sp = new SP("sp_usuario_selectByNick");
        $result = $sp->select($name);

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        return json_encode(Usuario::parse($result[0]));
    }

    function getUserByEmail($email) {

        $sp = new SP("sp_usuario_selectByEmail");
        $result = $sp->select($email);

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        return json_encode(Usuario::parse($result[0]));
    }

    function createUser($nodo) {

        $sp = new SP("sp_usuario_create");
        $result = $sp->insertOrUpdate($nodo->id_rol, $nodo->nick, $nodo->password, $nodo->email);

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        return $result;
    }

    function validateUser($nodo) {

        $sp = new SP("sp_usuario_validate");
        $result = $sp->select($nodo->nick, $nodo->password);

        if(!$sp->isSuccess()) {
            die($sp->errorMessage);
        }

        if ($result == null || count($result) <= 0) {
            return null;
        }

        return json_encode(Usuario::parse($result[0]));
    }

    function loginUser($nodo) {

        if (!isset($_SESSION)) {
            session_start();
        }

        $_SESSION["auth_user"] = $nodo;

        return true;
    }

    function logout() {

        if (!isset($_SESSION)) {
            session_start();
        }

        unset($_SESSION["auth_user"]);
    }
?>