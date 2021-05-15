<?php

    class NivelCurso
    {
        public int $id_nivel_curso;

        public int $id_curso;

        public int $orden;

        public float $precio;

        public string $titulo;

        public string $descripcion;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Curso::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new NivelCurso();

            $nodo->id_nivel_curso = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_curso = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->orden = !is_null($row[2]) ? (int)$row[2] : 0;
            $nodo->precio = !is_null($row[3]) ? (int)$row[3] : 0;
            $nodo->titulo = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->descripcion = !is_null($row[5]) ? (string)$row[5] : "";
            $nodo->fecha_alta =!is_null($row[6]) ? (string)$row[6] : "";
            $nodo->fecha_mod = !is_null($row[7]) ? (string)$row[7] : "";

            return $nodo;
        }
    }

?>