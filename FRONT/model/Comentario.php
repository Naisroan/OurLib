<?php

    class Comentario
    {
        public int $id_comentario;

        public int $id_usuario;

        public int $id_curso;

        public string $comentario;

        public int $valoracion;

        public string $nick_usuario;

        public string $nombre_usuario;

        public string $imagen_usuario;

        public string $tipo_imagen_usuario;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Comentario::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Comentario();

            $nodo->id_comentario = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_usuario = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->id_curso = !is_null($row[2]) ? (int)$row[2] : 0;
            $nodo->comentario = !is_null($row[3]) ? (string)$row[3] : "";
            $nodo->valoracion = !is_null($row[4]) ? (int)$row[4] : 0;
            $nodo->nick_usuario = !is_null($row[5]) ? (string)$row[5] : "";
            $nodo->nombre_usuario = !is_null($row[6]) ? (string)$row[6] : "";
            $nodo->imagen_usuario = !is_null($row[7]) ? (string)$row[7] : "";
            $nodo->tipo_imagen_usuario = !is_null($row[8]) ? (string)$row[8] : "";
            $nodo->fecha_alta =!is_null($row[9]) ? (string)$row[9] : "";
            $nodo->fecha_mod = !is_null($row[10]) ? (string)$row[10] : "";

            return $nodo;
        }
    }

?>