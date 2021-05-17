<?php

    # example.php

    define('TITLE', 'Aprendizaje');
    define('FOLDER_NAME', 'curso_learning');
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
    $id_curso = isset($_GET["id"]) ? $_GET["id"] : 0;
    $id_nivel_curso = isset($_GET["id_nivel_curso"]) ? $_GET["id_nivel_curso"] : 0;

    if ($id_curso <= 0) {
        header("Location: /index.php");
        exit();
    }
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
        <input id="txtId" type="text" value="0" class="d-none invisible">
        <input id="txtIdNivelCurso" type="text" value="0" class="d-none invisible">

        <!-- content -->
        <div class="container">
            <div class="row my-3">
                <div class="col-12 col-lg-4 col-xl-3">
                    <div class="mb-3">
                        <span class="me-2">Seleccione un nivel...</span>
                        <!-- <span class="badge bg-primary">90% de progreso</span> -->
                    </div>
                    <div id="niveles" class="list-group" id="list-tab" role="tablist">
                        <!-- <a class="list-group-item list-group-item-action" id="list-1-list" href="#!">
                            <strong>
                                Titulo nivel #1
                            </strong>
                        </a> -->
                    </div>
                </div>
                <div class="col-12 col-lg-8 col-xl-9">

                    <?php
                        if ($id_nivel_curso <= 0) {
                    ?>

                        <div class="row g-3">
                            <div class="col-12">
                                <div id="image" class="mx-auto image-curso">
                                </div>
                            </div>
                            <div class="col-12">
                                <h1 id="title" class="h4 my-0"></h1>
                            </div>
                            <div class="col-12">
                                <h2 id="subtitle" class="h5 my-0"></h2>
                            </div>
                            <div class="col-12">
                                <p id="description" class="lead my-0"></p>
                            </div>
                        </div>


                    <?php
                        } else {
                    ?>

                        <div class="row g-3">
                            <div class="col-12">
                                <span id="titlenivel" class="me-2"></span>
                            </div>
                            <div class="col-12">
                                <div class="ratio ratio-16x9">
                                    <video id="videonivel" controls>
                                        <!-- <source src="/res/examples/curso.mp4" type="video/mp4"> -->
                                    </video>
                                </div>
                            </div>
                            <div class="col-12">
                                <strong class="">Recursos multimedia</strong>
                            </div>
                            <div class="col-12">
                                <ul id="ulNivelArchivos" class="list-group list-group-flush">
                                </ul>
                            </div>
                        </div>

                    <?php
                        }
                    ?>

                </div>
            </div>
        </div>

    </div>

    <!-- scripts -->
    <?php require_once('../../templates/scripts_site.php'); ?>
    <script src="<?php echo URL_JS ?>"></script>

</body>

</html>