<?php

    # landing.php

    define('TITLE', 'Registrarse');
    define('FOLDER_NAME', 'register');
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
            <!-- <a href="/index.php">BISONTECA</a> -->
            <a href="/index.php">
                <img src="/res/logos/bisonteca_blanco_trans.png" alt="" srcset="" width="320px" style="filter: invert(1);">
            </a>
        </h1>

        <div class="box">
            <div class="box-wrapper">
                <div class="instrucciones py-5 text-center">
                    <h2 class="text-bisonteca">Registrarse</h2>
                    <p class="lead mb-0">¡Ingresa tus datos!</p>
                </div>
                <div class="row g-3">
                    <div class="col-12">
                        <label for="" class="label-form">Usuario</label>
                        <input id="txtUsuario" name="txtUsuario"  type="text" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Tipo de usuario</label>
                        <select name="txtTipo" id="txtTipo" class="form-select form-select-lg">
                            <option value="0">Seleccione...</option>
                            <option value="1">Creador</option>
                            <option value="2">Alumno</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Correo electronico</label>
                        <input name="txtCorreo" id="txtCorreo" type="text" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Confirmar correo</label>
                        <input name="txtConfirmCorreo" id="txtConfirmCorreo" type="text" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Contraseña</label>
                        <input name="txtPassword" id="txtPassword" type="password" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <label for="" class="label-form">Confirmar contraseña</label>
                        <input name="txtConfirmPassword" id="txtConfirmPassword" type="password" class="form-control form-control-lg">
                    </div>
                    <div class="col-12">
                        <a href="#!" class="btn btn-lg btn-bisonteca w-100 mt-4" onclick="registrar();">
                            <i class="fas fa-fw fa-sign-in-alt mr-3"></i> 
                            Registrarse
                        </a>
                    </div>
                    <div class="col-12">
                        <hr>
                    </div>
                    <div class="col-12 text-center">
                        ¿Ya tienes una cuenta? 
                        <strong>
                            <a href="/mods/login/login.php" class="text-bisonteca">Haz click aqui para iniciar sesión</a>
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