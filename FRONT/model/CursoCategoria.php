<?php

    class CursoCategoria
    {
        public int $id_curso_categoria;

        public int $id_categoria;

        public int $id_curso;

        public string $categoria;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, CursoCategoria::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new CursoCategoria();

            $nodo->id_curso_categoria = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_curso = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->categoria = !is_null($row[2]) ? (string)$row[2] : "";
            $nodo->fecha_alta =!is_null($row[3]) ? (string)$row[3] : "";
            $nodo->fecha_mod = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->categoria = !is_null($row[5]) ? (string)$row[5] : "";

            return $nodo;
        }
    }

?>