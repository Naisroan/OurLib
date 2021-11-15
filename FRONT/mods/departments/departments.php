<?php

    # example.php

    define('TITLE', 'Departamentos');
    define('FOLDER_NAME', 'departments');
    define('URL_CSS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".css");
    define('URL_JS', '/mods/' . FOLDER_NAME . '/' . FOLDER_NAME . ".js");

    # code

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
    $id_rol_especial = isset($usuarioLogeado->id_rol_especial) ? $usuarioLogeado->id_rol_especial: 0;

    if ($id_rol_especial != 1) {
        header("Location: /index.php");
        exit();
    }
?>

<!DOCTYPE html>
<html lang="es-mx" class="overflow-hidden">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OurLib © - <?php echo TITLE ?></title>
    <?php require_once('../../templates/styles_site.php'); ?>
    <link rel="stylesheet" href="<?php echo URL_CSS ?>">
    <link rel='shortcut icon' type='image/x-icon' href='/favicon.ico' />
</head>

<body>

    <!-- menu -->
    <?php require_once('../../templates/header_menu.php') ?>

    <div class="wrapper">

        <!-- content -->
        <div class="container-fluid">
            <div class="row py-4">
                <div class="col-12">
                    <h1>Departamentos</h1>
                    <small class="text-muted">Seleccione que usuarios pueden crear contenido</small>
                </div>
                <div class="col-12">
                    <hr>
                </div>
                <div class="col-12">
                </div>
                <div class="col-12 table-responsive">
                    <table id="tblUsuarios" class="table table-dark">
                        <thead class="bg-ourlib">
                            <tr>
                                <th>Es departamento</th>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Organización/Nombre</th>
                                <th>Correo</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>