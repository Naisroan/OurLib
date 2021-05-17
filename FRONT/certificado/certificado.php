<?php
    # librerias

    # code

    if (!isset($_SESSION))
    {
        session_start();
    }

    // si el usuario no esta logeado se redirecciona al login
    if (!isset($_SESSION["auth_user"]))
    {
        die("El usuario tiene que tener la sesión iniciada");
    }

    $usuarioLogeado = $_SESSION["auth_user"];
    $id_curso = isset($_GET["id_curso"]) ? $_GET["id_curso"] : 0;

    if ($id_curso <= 0) {
        die("No se pudo generar el certificado ya que el identificador del curso es invalido");
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Certificado</title>
    <style>

        * {
            margin: 0;
            padding: 0;
        }

        body {
            position: relative;
        }

        .text {
            position: absolute;
            left: 0;
            top: 568px;
            right: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 300;
            font-size: 80px;
            text-align: center;
            font-variant-caps: all-small-caps;
        }

        #image {
            position: absolute;
            left: 1054px;
            top: 100px;
            height: 220px;
            width: 220px;
            background-position: center center;
            background-size: cover;
        }

        #nombre {
            top: 368px;
        }

        #curso {
            top: 570px;
            font-weight: 300;
        }

        #autor-image {
            max-height: 100vh;
            margin: 0 auto;
        }

        @media print {
            body{
                width: 21cm;
                height: 29.7cm;
                margin: 30mm 45mm 30mm 45mm; 
                /* change the margins as you want them to be. */
            } 
        }
    </style>
</head>
<body>

    <input id="txtId" type="text" value="<?php echo $id_curso ?>" style="display:none;">

    <img id="autor-image" src="/certificado/public/Certificado01.jpg" style="line-height: 0;display: block;" />
    <img id="image" src="/certificado/public/user.png">
    <span id="nombre" class="text">
        <?php echo $usuarioLogeado->nombre != "" ? $usuarioLogeado->nombre . ' ' . $usuarioLogeado->ap_paterno . ' ' . $usuarioLogeado->ap_materno : "Actualiza tu nombre en tu cuenta" ?>
    </span>
    <span id="curso" class="text">
    </span>

    <script src="//cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="/site.js"></script>
    <script src="certificado.js"></script>
</body>
</html>