<?php

    class Curso
    {
        public int $id_curso;

        public int $id_usuario;

        public string $titulo;

        public string $subtitulo;

        public string $descripcion;

        public float $precio;

        public bool $activo;

        public string $imagen;

        public string $fecha_alta;

        public string $fecha_mod;

        public string $tipo_imagen;

        public string $nick_usuario;

        public string $votos_positivos;

        public string $votos_negativos;

        public string $cantidad_ventas;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Curso::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Curso();

            $nodo->id_curso = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_usuario = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->titulo = !is_null($row[2]) ? (string)$row[2] : "";
            $nodo->subtitulo = !is_null($row[3]) ? (string)$row[3] : "";
            $nodo->descripcion = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->precio = !is_null($row[5]) ? (float)$row[5] : 0;
            $nodo->activo = !is_null($row[6]) ? (string)$row[6] : false;
            $nodo->imagen = !is_null($row[7]) ? base64_encode($row[7]) : "";
            $nodo->fecha_alta =!is_null($row[8]) ? (string)$row[8] : "";
            $nodo->fecha_mod = !is_null($row[9]) ? (string)$row[9] : "";
            $nodo->tipo_imagen = !is_null($row[10]) ? (string)$row[10] : "";
            $nodo->nick_usuario = !is_null($row[11]) ? (string)$row[11] : "";
            $nodo->votos_positivos = !is_null($row[12]) ? (int)$row[12] : 0;
            $nodo->votos_negativos = !is_null($row[13]) ? (int)$row[13] : 0;
            $nodo->cantidad_ventas = !is_null($row[14]) ? (int)$row[14] : 0;

            return $nodo;
        }
    }

?>