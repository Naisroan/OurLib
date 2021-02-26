<?php

    # search.php

    define('TITLE', 'Cursos');
    define('FOLDER_NAME', 'search');
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
</head>

<body>

    <div class="wrapper">

        <!-- menu -->
        <?php require_once('../../templates/header_menu.php') ?>

        <!-- content -->
        <div class="container my-5">
            <div class="row">
            <div class="filters col-12 col-lg-4 col-xl-3">
                    <div class="row g-3">
                        <div class="col-12 mb-3">
                            <h5>Filtros</h5>
                        </div>
                        <div class="col-12 mb-3">
                            <h5>                            
                                Tema del curso
                            </h5>
                            <input type="text" class="form-control form-control-lg" placeholder="Tema del curso..." />
                        </div>
                        <div class="col-12 mb-3">
                            <h5>                            
                                Categoría
                            </h5>
                            <select class="form-select form-select-lg">
                                <option>Seleccione...</option>
                                <option>Desarrollo</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="results col-12 col-lg-8 col-xl-9">
                    
                    <h2>Resultados</h2>
                    <p class="text-muted">
                        De acuerdo a los filtros especificados.
                    </p>
                    <div class="row">
                        <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                            <div class="card">
                                <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        Card title
                                        <small>
                                            <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                        </small>
                                        <small class="d-block text-muted">
                                            Autor
                                        </small>
                                    </h5>
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                        <i class="fas fa-info me-2"></i>
                                        <span class="fw-normal fs-5">Ver más</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                            <div class="card">
                                <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        Card title
                                        <small>
                                            <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                        </small>
                                        <small class="d-block text-muted">
                                            Autor
                                        </small>
                                    </h5>
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                        <i class="fas fa-info me-2"></i>
                                        <span class="fw-normal fs-5">Ver más</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                            <div class="card">
                                <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        Card title
                                        <small>
                                            <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                        </small>
                                        <small class="d-block text-muted">
                                            Autor
                                        </small>
                                    </h5>
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                        <i class="fas fa-info me-2"></i>
                                        <span class="fw-normal fs-5">Ver más</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="card-wrapper col-6 col-lg-4 col-xl-3">
                            <div class="card">
                                <img src="http://lorempixel.com/280/150" class="card-img-top" alt="">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        Card title
                                        <small>
                                            <span class="badge bg-secondary fw-normal">Lorem ipsum</span>
                                        </small>
                                        <small class="d-block text-muted">
                                            Autor
                                        </small>
                                    </h5>
                                    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                                    <a href="/mods/curso_detail/curso_detail.php?id=0" class="btn btn-sm btn-bisonteca w-100 justify-content-center">
                                        <i class="fas fa-info me-2"></i>
                                        <span class="fw-normal fs-5">Ver más</span>
                                    </a>
                                </div>
                            </div>
                        </div>
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