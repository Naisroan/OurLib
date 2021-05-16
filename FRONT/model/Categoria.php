<?php

    class Categoria
    {
        public int $id_categoria;

        public string $nombre;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Categoria::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Categoria();

            $nodo->id_categoria = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->nombre = !is_null($row[1]) ? (string)$row[1] : "";
            $nodo->fecha_alta =!is_null($row[2]) ? (string)$row[2] : "";
            $nodo->fecha_mod = !is_null($row[3]) ? (string)$row[3] : "";

            return $nodo;
        }
    }

?>