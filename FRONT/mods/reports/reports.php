<?php

    # example.php

    define('TITLE', 'Reportes');
    define('FOLDER_NAME', 'reports');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    # code

    if (!isset($_SESSION)) {
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

        <!-- id -->
        <input id="txtIdRol" type="text" value="<?php echo $usuarioLogeado->id_rol ?>" class="d-none invisible">

        <!-- content -->
        <div class="container my-4">
            <div class="row g-3">

                <?php if ($usuarioLogeado->id_rol == 1) { ?>

                    <div class="col-12">
                        <h4>Reportes totales</h4>
                    </div>

                    <div class="col-12">
                        <div class="row g-3">
                            <div class="col-12 col-lg-4 col-xl-3 rp-card">
                                <strong class="fs-3">
                                    <span>$</span>
                                    <span id="ganancia">0.00</span>
                                    <span>MXN</span>
                                </strong>
                                <p class="m-0">
                                    Ganancias totales
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <hr>
                    </div>

                    <div class="col-12">
                        <h4>Reporte de cursos</h4>
                    </div>

                    <div class="col-12">
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col">Curso</th>
                                        <th scope="col">Cantidad de alumnos</th>
                                        <th scope="col">Cantidad de ventas</th>
                                        <th scope="col">Total</th>
                                    </tr>
                                </thead>
                                <tbody id="ventastotales">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-12">
                        <hr>
                    </div>

                    <div class="col-12">
                        <h4>Reporte de ventas</h4>
                    </div>

                    <div class="col-12">
                        <div class="table-responsive">
                            <table class="table table-borderless">
                                <thead>
                                    <tr>
                                        <th scope="col">ID</th>
                                        <th scope="col">Usuario</th>
                                        <th scope="col">Forma de pago</th>
                                        <th scope="col">Monto pago</th>
                                        <th scope="col">Curso</th>
                                        <th scope="col">Fecha de finalización</th>
                                    </tr>
                                </thead>
                                <tbody id="ventas">
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="col-12">
                        <hr>
                    </div>

                <?php } ?>

                    <div class="col-12">
                        <h4>Historial de mis cursos adquiridos con actividad</h4>
                    </div>

                    <table class="table table-borderless">
                        <thead>
                            <tr>
                                <th scope="col">Curso</th>
                                <th scope="col">Niveles</th>
                                <th scope="col">Completados</th>
                                <th scope="col">Progreso</th>
                                <th scope="col">Fecha de finalizacion</th>
                                <th scope="col">Certificado</th>
                            </tr>
                        </thead>
                        <tbody id="historial">
                        </tbody>
                    </table>

            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>