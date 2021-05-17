<?php

    class Venta
    {
        public int $id_venta;

        public int $id_usuario;

        public int $id_curso;

        public int $id_nivel_curso;

        public string $forma_pago;

        public float $monto_pago;

        public string $fecha_finalizacion;

        public string $nick_usuario;

        public string $nombre_usuario;

        public string $curso;

        public string $nivel_curso;

        public string $fecha_alta;

        public string $fecha_mod;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, Venta::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new Venta();

            $nodo->id_venta = !is_null($row[0]) ? (int)$row[0] : 0;
            $nodo->id_usuario = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->id_curso = !is_null($row[2]) ? (int)$row[2] : 0;
            $nodo->id_nivel_curso = !is_null($row[3]) ? (int)$row[3] : 0;

            $nodo->forma_pago = !is_null($row[4]) ? (string)$row[4] : "";
            $nodo->monto_pago = !is_null($row[5]) ? (float)$row[5] : "";
            
            $nodo->fecha_finalizacion = !is_null($row[6]) ? (string)$row[6] : "";

            $nodo->nick_usuario = !is_null($row[7]) ? (string)$row[7] : "";
            $nodo->nombre_usuario = !is_null($row[8]) ? (string)$row[8] : "";
            $nodo->curso = !is_null($row[9]) ? (string)$row[9] : "";
            $nodo->nivel_curso = !is_null($row[10]) ? (string)$row[10] : "";

            $nodo->fecha_alta =!is_null($row[11]) ? (string)$row[11] : "";
            $nodo->fecha_mod = !is_null($row[12]) ? (string)$row[12] : "";

            return $nodo;
        }
    }

    class VentaReporte
    {
        public string $curso;

        public int $cantidad_alumnos;

        public int $cantidad_ventas;

        public int $total_curso;

        public static function parseArrayToList($array) {

            $list = array();
    
            foreach ($array as $row) {
                array_push($list, VentaReporte::parse($row));
            }

            return $list;
        }

        public static function parse($row) {

            $nodo = new VentaReporte();

            $nodo->curso = !is_null($row[0]) ? (string)$row[0] : "";

            $nodo->cantidad_alumnos = !is_null($row[1]) ? (int)$row[1] : 0;
            $nodo->cantidad_ventas = !is_null($row[2]) ? (int)$row[2] : 0;
            $nodo->total_curso = !is_null($row[3]) ? (float)$row[3] : 0;

            return $nodo;
        }
    }
?>