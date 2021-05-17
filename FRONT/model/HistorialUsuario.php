<?php

    class HistorialUsuario
    {
        public int $id_historial_usuario;

        public int $id_usuario;

        public int $id_curso;

        public string $id_nivel_curso;

        public string $curso;

        public string $nivel_curso;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, HistorialUsuario::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new HistorialUsuario();

            $nodo->id_historial_usuario = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_usuario = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->id_curso = !is_null($row[2]) ? (int)$row[2] : "";
            $nodo->id_nivel_curso = !is_null($row[3]) ? (string)$row[3] : "";

            $nodo->curso = !is_null($row[4]) ? (string)($row[4]) : "";
            $nodo->nivel_curso = !is_null($row[5]) ? (string)$row[5] : "";

            $nodo->fecha_alta =!is_null($row[6]) ? (string)$row[6] : "";
            $nodo->fecha_mod = !is_null($row[7]) ? (string)$row[7] : "";

            return $nodo;
        }
    }

    class HistorialUsuarioReporte
    {
        public int $id_usuario;

        public int $id_curso;

        public string $nick_usuario;

        public string $nombre_usuario;

        public string $curso;

        public int $cant_niveles_completados;

        public int $cant_niveles_curso;

        public float $porcentaje_completado;

        public string $fecha_finalizacion;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, HistorialUsuarioReporte::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new HistorialUsuarioReporte();

            $nodo->id_usuario = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_curso = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->nick_usuario = !is_null($row[2]) ? (string)$row[2] : "";
            $nodo->nombre_usuario = !is_null($row[3]) ? (string)($row[3]) : "";
            $nodo->curso = !is_null($row[4]) ? (string)$row[4] : "";

            $nodo->cant_niveles_completados = !is_null($row[5]) ? (int)$row[5] : 0;
            $nodo->cant_niveles_curso = !is_null($row[6]) ? (int)$row[6] : 0;

            $nodo->porcentaje_completado = !is_null($row[7]) ? (float)$row[7] : 0;
            $nodo->fecha_finalizacion = !is_null($row[8]) ? (string)$row[8] : 0;

            return $nodo;
        }
    }

?>