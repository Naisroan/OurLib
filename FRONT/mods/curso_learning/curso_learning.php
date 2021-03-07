<?php

    # example.php

    define('TITLE', 'Aprendizaje');
    define('FOLDER_NAME', 'curso_learning');
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
        <div class="container-fluid">
            <div class="row my-3">
                <div class="col-12 col-lg-8 col-xl-9">
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="list-1" role="tabpanel" aria-labelledby="list-1-list">
                            <div class="ratio ratio-16x9 mb-4">
                                <video controls>
                                    <source src="/res/examples/curso.mp4" type="video/mp4">
                                </video>
                            </div>
                            <div class="mb-4">
                                <div class="mb-3">
                                    <strong class="">Contenido del nivel</strong>
                                </div>
                                <div class="">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">
                                            <a href="#!">
                                                recursos.docx
                                            </a>
                                        </li>
                                        <li class="list-group-item">
                                            <a href="#!">
                                                contenido.pptx
                                            </a>
                                        </li>
                                        <li class="list-group-item">
                                            <a href="#!">
                                                repaso.mp4
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="tab-pane fade" id="list-2" role="tabpanel" aria-labelledby="list-2-list">
                            <div class="ratio ratio-16x9">
                                <video controls>
                                    <source src="/res/examples/curso.mp4" type="video/mp4">
                                </video>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="list-3" role="tabpanel" aria-labelledby="list-3-list">
                            <div class="ratio ratio-16x9">
                                <video controls>
                                    <source src="/res/examples/curso.mp4" type="video/mp4">
                                </video>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="list-4" role="tabpanel" aria-labelledby="list-4-list">
                            <div class="ratio ratio-16x9">
                                <video controls>
                                    <source src="/res/examples/curso.mp4" type="video/mp4">
                                </video>
                            </div>
                        </div> -->
                    </div>
                </div>
                <div class="col-12 col-lg-4 col-xl-3">
                    <div class="mb-3">
                        <strong class="">Niveles del curso</strong>
                    </div>
                    <div class="list-group list-group-flush" id="list-tab" role="tablist">
                        <a class="list-group-item list-group-item-action active" id="list-1-list" data-bs-toggle="list" href="#list-1" role="tab" aria-controls="1">
                            <strong>
                                Titulo nivel #1
                            </strong>
                        </a>
                        <a class="list-group-item list-group-item-action" id="list-2-list" data-bs-toggle="list" href="#list-2" role="tab" aria-controls="2">
                            <strong>
                                Titulo nivel #2
                            </strong>
                        </a>
                        <a class="list-group-item list-group-item-action" id="list-3-list" data-bs-toggle="list" href="#list-3" role="tab" aria-controls="3">
                            <strong>
                                Titulo nivel #3
                            </strong>
                        </a>
                        <a class="list-group-item list-group-item-action" id="list-4-list" data-bs-toggle="list" href="#list-4" role="tab" aria-controls="4">
                            <strong>
                                Titulo nivel #4
                            </strong>
                        </a>
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