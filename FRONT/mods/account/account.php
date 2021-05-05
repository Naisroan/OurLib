<?php

    # example.php

    define('TITLE', 'Cuenta');
    define('FOLDER_NAME', 'account');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    if (!isset($_SESSION))
    {
        session_start();
    }

    // si el usuario no esta logeado se redirecciona al login
    if (!isset($_SESSION["auth_user"]))
    {
        header("Location: /mods/login/login.php");
        exit();
    }

    $usuarioLogeado = $_SESSION["auth_user"];
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
                        <form id="frmChangeImage" action="post" class="row g-3 mb-3" enctype="multipart/form-data">
                            <div class="col-12 text-center">
                                <div
                                    id="imgUsuario"
                                    style='background-image: url(<?php
                                        echo $usuarioLogeado->imagen != null
                                            ? "data:" . $usuarioLogeado->tipo_imagen . ";base64," . $usuarioLogeado->imagen
                                            : "/res/examples/user.png"
                                    ?>);'
                                    class="usuario rounded-circle mx-auto" 
                                    alt="">
                                </div>
                            </div>
                            <div class="col-12 col-lg-12">
                                <label for="formFile" class="form-label">Seleccione la imagen</label>
                                <input id="profile_image" class="form-control" type="file" id="formFile">
                            </div>
                            <div class="col-12">
                                <button id="btnGuardarImagen" type="submit" class="btn btn-bisonteca">
                                    <span class="spinner-grow spinner-grow visually-hidden me-2" role="status" aria-hidden="true"></span>
                                    <i class="fas fa-save me-2"></i>
                                    <span class="text">Guardar</span>
                                </button>
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
                                <input id="txtPassword" type="password" class="form-control" placeholder="Contraseña nueva"
                                    data-bs-container="body" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-trigger="hover focus"
                                    data-bs-html="true"
                                    title='
                                        <div class="text-start">
                                            <strong>Debe tener al menos:</strong>
                                            <ul class="m-0 ps-4 text-start">
                                                <li>8 caracteres</li>
                                                <li>Una mayúscula</li>
                                                <li>Una minúscula</li>
                                                <li>Un carácter especial</li>
                                                <li>Un número</li>
                                            </ul>
                                        </div>
                                    '
                                    data-bs-content="Debe tener mínimo 8 caracteres, una mayúscula, minúscula, y un carácter especial"
                                >
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Confirmar nueva contraseña
                                </label>
                                <input id="txtConfirmPassword" type="password" class="form-control" placeholder="Confirmar nueva contraseña">
                            </div>
                            <div class="col-12">
                                <div class="col-12">
                                    <a id="btnGuardarPassword" href="#!" class="btn btn-bisonteca" onclick="cambiarPassword();">
                                        <span class="spinner-grow spinner-grow visually-hidden me-2" role="status" aria-hidden="true"></span>
                                        <i class="fas fa-save me-2"></i>
                                        <span class="text">Guardar</span>
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
                                <input id="txtNombre" type="text" class="form-control" placeholder="Nombre(s)"
                                    value='<?php echo isset($usuarioLogeado) ? $usuarioLogeado->nombre : "" ?>'>
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Apellido Paterno
                                </label>
                                <input id="txtApPaterno" type="text" class="form-control" placeholder="Apellido Paterno"
                                    value='<?php echo isset($usuarioLogeado) ? $usuarioLogeado->ap_paterno : "" ?>'>
                            </div>
                            <div class="col-12">
                                <label for="" class="label-form">
                                    Apellido Materno
                                </label>
                                <input id="txtApMaterno" type="text" class="form-control" placeholder="Apellido Materno"
                                    value='<?php echo isset($usuarioLogeado) ? $usuarioLogeado->ap_materno : "" ?>'>
                            </div>
                            <div class="col-12">
                                <div class="col-12">
                                    <a id="btnGuardarNombre" href="#!" class="btn btn-bisonteca" onclick="cambiarNombre();">
                                        <span class="spinner-grow spinner-grow visually-hidden me-2" role="status" aria-hidden="true"></span>
                                        <i class="fas fa-save me-2"></i>
                                        <span class="text">Guardar</span>
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