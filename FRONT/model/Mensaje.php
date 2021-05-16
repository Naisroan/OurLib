<?php

    class Mensaje
    {
        public int $id_mensaje;

        public int $id_usuario_rem;

        public int $id_usuario_dest;

        public string $nick_usuario_rem;

        public string $imagen_usuario_rem;

        public string $tipo_imagen_usuario_rem;

        public string $nick_usuario_dest;

        public string $imagen_usuario_dest;

        public string $tipo_imagen_usuario_dest;

        public string $mensaje;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Mensaje::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Mensaje();

            $nodo->id_mensaje = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_usuario_rem = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->id_usuario_dest = !is_null($row[2]) ? (string)$row[2] : "";

            $nodo->nick_usuario_rem = !is_null($row[3]) ? (string)$row[3] : "";
            $nodo->imagen_usuario_rem = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->tipo_imagen_usuario_rem = !is_null($row[5]) ? (string)$row[5] : "";

            $nodo->nick_usuario_dest = !is_null($row[6]) ? (string)$row[6] : "";
            $nodo->imagen_usuario_dest = !is_null($row[7]) ? (string)$row[7] : "";
            $nodo->tipo_imagen_usuario_dest = !is_null($row[8]) ? (string)$row[8] : "";
            
            $nodo->mensaje = !is_null($row[9]) ? (string)$row[9] : "";

            $nodo->fecha_alta =!is_null($row[10]) ? (string)$row[10] : "";
            $nodo->fecha_mod = !is_null($row[11]) ? (string)$row[11] : "";

            return $nodo;
        }
    }

?>