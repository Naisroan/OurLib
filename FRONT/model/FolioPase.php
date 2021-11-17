<?php

    class FolioPase
    {
        public int $id_foliopase;

        public int $id_curso;

        public string $folio;

        public int $activo;

        public string $fecha_vigencia;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, FolioPase::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new FolioPase();

            $nodo->id_foliopase = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_curso = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->folio = !is_null($row[2]) ? (string)$row[2] : "";
            $nodo->activo = !is_null($row[3]) ? (int)$row[3] : 0;
            $nodo->fecha_vigencia =!is_null($row[4]) ? date('Y-m-d', strtotime($row[4])) : "";
            $nodo->fecha_alta =!is_null($row[5]) ? (string)$row[5] : "";
            $nodo->fecha_mod = !is_null($row[6]) ? (string)$row[6] : "";

            return $nodo;
        }
    }

?>