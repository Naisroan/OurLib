<?php

    # example.php

    define('TITLE', 'Cuenta');
    define('FOLDER_NAME', 'account');
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
        <?php require_once('../../templates/header_menu.php') ?>

        <!-- content -->
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-6 col-lg-4 mx-auto">
                    <div class="account-wrapper my-5">
                        <form action="" class="row g-3 mb-3">
                            <div class="col-12 text-center">
                                <img src="/res/examples/user.png" class="usuario rounded-circle" alt="">
                            </div>
                            <div class="col-12 col-lg-12">
                                <label for="formFile" class="form-label">Seleccione la imagen</label>
                                <input id="profile_image" class="form-control" type="file" id="formFile">
                            </div>
                            <div class="col-12">
                                <a href="#!" class="btn btn-bisonteca" onclick="imagen_perfil();">
                                    <i class="fas fa-save me-2"></i>Guardar
                                </a>
                            </div>
                            <div class="col-12">
                                <hr>
                            </div>
                        </form>
                        <form action="" class="row g-3 mb-3">
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Contraseña actual
                                </label>
                                <input id="txtActualPassword" type="password" class="form-control" placeholder="Contraseña actual">
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Contraseña nueva
                                </label>
                                <input id="txtPassword" type="password" class="form-control" placeholder="Contraseña nueva">
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Confirmar nueva contraseña
                                </label>
                                <input id="txtConfirmPassword" type="password" class="form-control" placeholder="Confirmar nueva contraseña">
                            </div>
                            <div class="col-12">
                                <div class="col-12">
                                    <a href="#!" class="btn btn-bisonteca" onclick="guardar_cambios();">
                                        <i class="fas fa-save me-2"></i>Guardar
                                    </a>
                                </div>
                            </div>
                            <div class="col-12">
                                <hr>
                            </div>
                        </form>
                        <form action="" class="row g-3 mb-3">
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Nombre(s)
                                </label>
                                <input id="txtNombre" type="text" class="form-control" placeholder="Nombre(s)">
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Apellido Paterno
                                </label>
                                <input id="txtApPaterno" type="text" class="form-control" placeholder="Apellido Paterno">
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Apellido Materno
                                </label>
                                <input id="txtApMaterno" type="text" class="form-control" placeholder="Apellido Materno">
                            </div>
                            <div class="col-12">
                                <div class="col-12">
                                    <a href="#!" class="btn btn-bisonteca" onclick="guardar_cambios_nombre();">
                                        <i class="fas fa-save me-2"></i>Guardar
                                    </a>
                                </div>
                            </div>
                        </form>
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