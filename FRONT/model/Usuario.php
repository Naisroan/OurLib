<?php

    class Usuario
    {
        public int $id_usuario;

        public int $id_rol;

        public string $email;

        public string $nick;

        public string $password;

        public string $nombre;

        public string $ap_paterno;

        public string $ap_materno;

        public string $imagen;

        public string $fecha_alta;

        public string $fecha_mod;

        public string $tipo_imagen;

        public int $id_rol_especial;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Usuario::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Usuario();

            $nodo->id_usuario = (int)$row[0];
            $nodo->id_rol = (int)$row[1];
            $nodo->email = (string)$row[2];
            $nodo->nick = (string)$row[3];
            $nodo->password = (string)$row[4];
            $nodo->nombre = (string)$row[5];
            $nodo->ap_paterno = (string)$row[6];
            $nodo->ap_materno = (string)$row[7];
            $nodo->imagen = !is_null($row[8]) ? base64_encode($row[8]) : "";
            $nodo->fecha_alta =(string)$row[9];
            $nodo->fecha_mod = (string)$row[10];
            $nodo->tipo_imagen = (string)$row[11];
            $nodo->id_rol_especial = isset($row[12]) ? (int)$row[12] : 0;

            return $nodo;
        }
    }

?>