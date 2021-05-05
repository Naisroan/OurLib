<?php

    # conbd.php

    class MySQLConnection
    {
        public const DB_HOST_NAME = "127.0.0.1";
        public const DB_USER_NAME = "root";
        public const DB_PASSWORD = "a1234567890A";
        public const DB_NAME = "bisonteca";
        public const DB_PORT = 3306;

        public $Connection = null;

        function __construct() {

            // hacemos conexion
            $this->Connection = new mysqli(self::DB_HOST_NAME, self::DB_USER_NAME, self::DB_PASSWORD, self::DB_NAME, self::DB_PORT);
        }

        function isConnected(&$message) {

            if ($this->Connection == null || $this->Connection->connect_errno) {

                // creamos un mensaje de error y lo pasamos por referencia
                $message = "ERR " . $this->Connection->connect_errno . ": \n\n" . $this->Connection->connect_error;
                return false;
            }

            return true;
        }

        function close() {
            
            $message = "";

            if (!$this->isConnected($message)) {
                return;
            }

            mysqli_close($this->Connection);
        }
    }
?>