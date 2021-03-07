<?php

    class Automovil
    {
        public $Marca = "";
        public $UrlImagen = "";

        function __construct(string $marca, string $url) 
        {
            $this->Marca = $marca;
            $this->UrlImagen = $url;
        }
    }

?>