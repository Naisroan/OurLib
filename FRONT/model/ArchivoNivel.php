<?php

    class ArchivoNivel
    {
        public int $id_multimedia_nivel;

        public int $id_nivel_curso;

        public string $ruta;

        public string $nombre;

        public string $extension;

        public string $tipo;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, ArchivoNivel::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new ArchivoNivel();

            $nodo->id_multimedia_nivel = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_nivel_curso = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->ruta = !is_null($row[2]) ? (string)$row[2] : "";
            $nodo->nombre = !is_null($row[3]) ? (string)$row[3] : "";
            $nodo->extension = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->tipo = !is_null($row[5]) ? (string)$row[5] : "";
            $nodo->fecha_alta =!is_null($row[6]) ? (string)$row[6] : "";
            $nodo->fecha_mod = !is_null($row[7]) ? (string)$row[7] : "";

            return $nodo;
        }
    }

?>