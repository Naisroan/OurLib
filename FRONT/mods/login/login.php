<?php

    # landing.php

    define('TITLE', 'Cuenta');
    define('FOLDER_NAME', 'login');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");
?>

<!DOCTYPE html>
<html lang="es-mx">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bisonteca © - <?php echo TITLE ?></title>
    <?php require_once('../../templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <div class="wrapper">

        <!-- menu -->
        <?php // require_once('../../templates/header_menu.php') ?>

        <!-- content -->
        <h1 class="display-4 mt-4 text-center bisonteca">
            <a href="/index.php">BISONTECA</a>
        </h1>

        <div class="box">
            <div class="box-wrapper">
                <div class="instrucciones py-5 text-center">
                    <h2 class="text-bisonteca">Iniciar Sesión</h2>
                    <p class="lead mb-0">¡Ingresa tus credenciales!</p>
                </div>
                <div class="row g-3">
                    <div class="col-12">
                        <label for="txtUsuario" class="label-form">Usuario</label>
                        <input id="txtUsuario" name="txtUsuario" type="text" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Contraseña</label>
                        <input type="password" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <div class="row g-3">
                            <div class="col-12 col-lg-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
                                    <label class="form-check-label" for="flexCheckDefault">
                                        Recordar usuario
                                    </label>
                                </div>
                            </div>
                            <div class="col-12 col-lg-6 text-end">
                                <a href="#!" class="text-bisonteca" onclick="recuperarContrasena();">Recuperar contraseña</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <a href="/index.php" class="btn btn-lg btn-bisonteca w-100 mt-4 submit">
                            <i class="fas fa-fw fa-sign-in-alt mr-3"></i>
                            Entrar
                        </a>
                    </div>
                    <div class="col-12">
                        <hr>
                    </div>
                    <div class="col-12 text-center">
                        ¿No tienes una cuenta? 
                        <strong>
                            <a href="/mods/register/register.php" class="text-bisonteca">
                                Haz click aqui para registrarte
                            </a>
                        </strong>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>