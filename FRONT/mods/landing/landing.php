<?php

    # landing.php

    define('TITLE', 'Inicio');
    define('FOLDER_NAME', 'landing');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    if(!isset($_SESSION)) {
        session_start(); 
    }

    $usuarioLogeado = null;

    if (isset($_SESSION["auth_user"])) {
        
        $usuarioLogeado = $_SESSION["auth_user"];
    }
?>

<!DOCTYPE html>
<html lang="es-mx" class="overflow-hidden">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OurLib © - <?php echo TITLE ?></title>
    <?php require_once('templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <!-- menu -->
    <?php require_once('templates/header_menu.php') ?>

    <div class="wrapper">

        <!-- content -->
        <div class="banner">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-6 mx-auto text-center">
                        <h1 class="text-white w-100">
                            <img src="/res/logos/ourlib.png" alt="" class="w-100" srcset="" style="drop-shadow(2px 4px 6px rgba(0, 0, 0, 0.25));">
                        </h1>
                        <hr class="text-white">
                        <p class="lead text-white">
                            Aprende, capacitate, explora. Tú educación, es tuya.
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <?php

        if (isset($usuarioLogeado) && $usuarioLogeado->id_rol == 1) {
        
        ?>

        <section class="container-fluid my-5">
            <h2>Contenido realizado</h2>
            <p class="text-muted">
                Visualiza y edita tu contenido
            </p>
            <div class="row" id="cursossubidos">
            </div>
        </section>

        <?php
            
        }

        ?>

        <?php

        if (isset($usuarioLogeado)) {
        
        ?>
        
        <section class="container-fluid my-5">
            <h2>Contenidos que te haz inscrito</h2>
            <p class="text-muted">
                Capacitate continuamente
            </p>
            <div id="cursosadquiridos" class="row">
            </div>
        </section>

        <?php
        }
        ?>
        
        <section class="container-fluid my-5">
            <h2>Contenido mas reciente</h2>
            <p class="text-muted">
                Descubre el contenido mas nuevo
            </p>
            <div class="row" id="cursosrecientes">
            </div>
        </section>

        <section class="container-fluid my-5 d-none">
            <h2>Contenido mas solicitado</h2>
            <p class="text-muted">
                Descubre el contenido mas adquirido por la comunidad
            </p>
            <div class="row" id="cursosmasvendidos">
            </div>
        </section>
        
        <section class="container-fluid my-5">
            <h2>Contenido mejor calificado</h2>
            <p class="text-muted">
                Descubre el contenido mas popular
            </p>
            <div class="row" id="cursosmasvistos">
            </div>
        </section>

        <footer class="mt-5 bg-dark">
            <div class="container-fluid py-5">
                <div class="row">
                    <div class="col-12">
                        <span>Powered By © Bisons Dev, Naisroan Dev <?php echo date("Y") ?></span>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- scripts -->
    <?php require_once('templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>